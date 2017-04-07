require 'open-uri'
require 'nokogiri'

class Scorer
  def initialize(notification_system, file, url = 'http://static.cricinfo.com/rss/livescores.xml')
    @url = url
    @notification = notification_system
    @file = file
  end

  # Game index refers to the position of the game one recieves
  # when they run ./scorer -l
  def run(game_index = nil)
    open(@url) do |f|
      score = if game_index
        Nokogiri::XML(f).xpath('//item//description')[game_index].text
      else
        Nokogiri::XML(f).xpath('//item//description').last.text
      end
      @notification.send_message(score, 'Scorer')
    end
  end

  def list
    open(@url) do |f|
      score = Nokogiri::XML(f).xpath('//item//description')
      score.each_with_index do |t, i|
        puts "#{i}. #{t.text}"
      end
    end
  end

  # Kill the scorer backgroung program
  def kill
    # We use the ps -fu $user command to ensure that only the scorer program run
    # by this user is found
    pid = get_pid
    unless get_pid.eql?(0)
      Process.kill('QUIT', pid)
    else
      puts 'Process not running'
    end
    sleep(1)

    unless get_pid.eql?(0)
      puts 'Process still running unable to kill for some reason'
    end
  end

  def daemon(game_index, refresh_time)
    Process.daemon(true)
    loop do
      pid = Process.fork do
        run game_index
      end
      Process.waitpid(pid)
      # Reduce CPU usage so the loop runs only every 30 seconds
      sleep(refresh_time)
    end
  end

  private

  def get_pid
    `/bin/ps -fu $USER| grep "#{@file} -d" | grep -v "grep" | awk '{print $2}'`.strip.to_i
  end
end

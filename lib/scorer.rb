require 'open-uri'
require 'nokogiri'

class Scorer
  def initialize url = 'http://static.cricinfo.com/rss/livescores.xml'
    @url = url
    @notification = NotificationSystem.new
  end

  def run
    open(@url) do |f|
      score = Nokogiri::XML(f).xpath("//item//description").text
      @notification.send_message(score)
    end
  end

  # Kill the scorer backgroung program
  def self.kill
    # We use the ps -fu $user command to ensure that only the scorer program run
    # by this user is found
    pid = get_pid
    unless get_pid.eql?(0)
      Process.kill('QUIT', pid)
    else
      puts "Process not running"
    end
    sleep(0.5)

    unless get_pid.eql?(0)
      puts "Process still running unable to kill for some reason"
    end
  end

  def daemon
    Process.daemon(true)
    loop do
      pid = Process.fork do
        run
      end
      Process.waitpid(pid)
      # Reduce CPU usage so the loop runs only every 30 seconds
      sleep(30)
    end
  end

  private

  def self.get_pid
    `/bin/ps -fu $USER| grep "test" | grep -v "grep" | awk '{print $2}'`.strip.to_i
  end
end

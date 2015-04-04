require 'open-uri'
require 'nokogiri'

class Scorer
  def initialize url = 'http://static.cricinfo.com/rss/livescores.xml'
    @url = url
    @notification = NotificationSystem.new
    @score = 0
  end

  def run
    open(@url) do |f|
      score = Nokogiri::XML(f).xpath("//item//description").text
      @notification.send_message(score)  and @score = score if score != @score
    end
  end
end
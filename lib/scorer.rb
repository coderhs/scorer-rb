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
end
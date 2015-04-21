require 'terminal-notifier'
require 'open-uri'
require 'nokogiri'
url = 'http://static.cricinfo.com/rss/livescores.xml'
open(url) do |f|
  msg = Nokogiri::XML(f).xpath("//item//description").last.text
  TerminalNotifier.notify(msg)
end

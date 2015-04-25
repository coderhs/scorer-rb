require 'os'
require 'terminal-notifier' if OS.mac?
require 'libnotify' if OS.linux?

class NotificationSystem
  def initialize
    fail 'OS type not supported by system' unless OS.mac? || OS.linux?
  end

  def send_message(msg, title)
    if defined?(TerminalNotifier)
      TerminalNotifier.notify(msg, title: title)
    elsif defined?(Libnotify)
      Libnotify.show(body: msg, summary: title)
    end
  end
end

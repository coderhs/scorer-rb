require 'os'
require 'terminal-notifier' if OS.mac?
require 'libnotify' if OS.linux?

class NotificationSystem
  def initialize 
    raise 'OS type not supported by system' unless OS.mac? or OS.linux?
  end

  def send_message msg
    if defined?(TerminalNotifier)
      TerminalNotifier.notify(msg, :title => 'Scorer')
    elsif defined?(Libnotify)
      Libnotify.show(:body => msg, :summary => 'Scorer')
    end
  end
end

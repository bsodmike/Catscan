module Catscan
  class Engine < ::Rails::Engine
    isolate_namespace Catscan

    initializer "catscan.scanner_subscribe", :after => :load_environment_config do |app|
      ActiveSupport::Notifications.subscribe 'log.scan' do |*args|
        event = ActiveSupport::Notifications::Event.new(*args)
        #ImportActivity.create!(
          #:import_id => event.payload[:import_id],
          #:message => event.payload[:message],
          #:name => event.name,
          #:started => event.time,
          #:finished => event.end,
          #:duration => event.duration,
          #:transaction_id => event.transaction_id,
          #:error_message => event.payload[:error_message],
          #:error_class => event.payload[:error_class],
          #:error_backtrace => event.payload[:error_backtrace]
        #)
      end
    end
  end
end

module Catscan
  class Engine < ::Rails::Engine
    isolate_namespace Catscan

    initializer "catscan.scanner_subscribe", :after => :load_environment_config do |app|
      ActiveSupport::Notifications.subscribe 'log.scan' do |*args|
        event = ActiveSupport::Notifications::Event.new(*args)
        ::Catscan::Scan.create!(
          :klass => event.payload[:klass_name],
          :comment => event.payload[:comment],
          :payload => event.payload
        )
      end
    end
  end
end

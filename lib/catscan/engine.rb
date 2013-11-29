module Catscan
  class Engine < ::Rails::Engine
    isolate_namespace Catscan

    initializer "catscan.scanner_subscribe", :after => :load_environment_config do |app|
      ActiveSupport::Notifications.subscribe 'log.scan' do |*args|
        event = ActiveSupport::Notifications::Event.new(*args)
        ::Catscan::Scan.create!(
          :klass => event.payload[:klass_name],
          :entity => event.payload[:entity].present? ? event.payload[:entity] : nil,
          :comment => event.payload[:comment].present? ? event.payload[:comment] : nil,
          :category => event.payload[:category],
          :error_message => event.payload[:error_message].present? ? event.payload[:error_message] : nil,
          :error_class => event.payload[:error_class].present? ? event.payload[:error_class] : nil,
          :error_backtrace => event.payload[:error_backtrace].present? ? Util.limit_bytesize(event.payload[:error_backtrace].force_encoding("UTF-8")) : nil
        )
      end
    end
  end
end

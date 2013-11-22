# encoding: utf-8

module Catscan
  module Scannable

    class << self
      def included _klass
        _klass.class_eval do
          _klass.send(:include, InstanceMethods)
          _klass.send(:include, CommonMethods)
          _klass.send(:extend, CommonMethods)
          _klass.send(:extend, ClassMethods)
        end
      end
    end

    module InstanceMethods

    end

    module CommonMethods

      def scan(context, comment = nil, &block)
        result = nil

        klass_name = context.class.name
        #comment = Util.limit_bytesize(message)

        ActiveSupport::Notifications.instrument("log.scan", :comment => "#{klass_name}: #{comment}") do
          result = context.instance_eval(&block)
        end
      rescue => ex
        puts "Logging Error!"
        ActiveSupport::Notifications.instrument("log.scan",
          :comment => "ERROR: #{klass_name}: #{comment}",
          :error_message => "#{ex.message}",
          :error_class => "#{ex.class}",
          :error_backtrace => "#{ex.backtrace}"
        )
      end

    end

    module ClassMethods

    end

  end
end

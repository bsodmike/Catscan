# encoding: utf-8

module Catscan
  module Scannable

    class << self
      def included _klass
        _klass.class_eval do
          _klass.send(:include, ScannerMethods)
          _klass.send(:extend, ScannerMethods)
        end
      end
    end

    module ScannerMethods

      def scan(context, comment = nil, &block)
        result = nil

        klass_name = context.class.name
        comment = Util.limit_bytesize(comment) if comment.present?

        ActiveSupport::Notifications.instrument("log.scan",
          :klass_name => klass_name,
          :comment => "#{klass_name}: #{comment}") do
          result = context.instance_eval(&block)
        end
      rescue => ex
        puts "Error!"

        # NOTE Re-raise exception for spec purposes
        raise if Rails.env.test?

        ActiveSupport::Notifications.instrument("log.scan",
          :klass_name => klass_name,
          :comment => "ERROR: #{klass_name}: #{comment}",
          :error_message => "#{ex.message}",
          :error_class => "#{ex.class}",
          :error_backtrace => "#{ex.backtrace}"
        )
      end

    end

  end
end

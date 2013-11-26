# encoding: utf-8

module Catscan
  module Scannable

    class << self
      def included _klass
        _klass.class_eval do
          _klass.send(:extend, ClassMethods)
        end
      end
    end

    module ClassMethods

      def scan(context, comment = nil, &block)
        klass_name = %w(Class).include?(context.class.name) ? context.name : context.class.name
        comment = Util.limit_bytesize(comment) if comment.present?

        ActiveSupport::Notifications.instrument("log.scan",
          :klass_name => klass_name,
          :comment => "#{klass_name}: #{comment}") do
          context.instance_eval(&block)
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

# encoding: utf-8
require 'catscan/util'

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

      def scan(context, entity = nil, comment = nil, category = :default, &block)
        klass_name = %w(Class).include?(context.class.name) ? context.name : context.class.name
        comment = Util.limit_bytesize(comment.force_encoding("UTF-8")) if comment.present?

        if block_given?
          ActiveSupport::Notifications.instrument("log.scan",
            :klass_name       => klass_name,
            :entity           => entity.present? ? "#{entity}" : nil,
            :comment          => comment.present? ? "#{comment}" : nil,
            :category         => "#{category}") do
            context.instance_eval(&block)
          end
        else
          ActiveSupport::Notifications.instrument("log.scan",
            :klass_name       => klass_name,
            :entity           => entity.present? ? "#{entity}" : nil,
            :comment          => comment.present? ? "#{comment}" : nil,
            :category         => "#{category}"
          )
        end
      rescue => ex
        puts "Error!"

        ActiveSupport::Notifications.instrument("log.scan",
          :klass_name       => klass_name,
          :entity           => entity.present? ? "#{entity}" : nil,
          :comment          => comment.present? ? "ERROR: #{comment}" : nil,
          :category         => "#{category}",
          :error_message    => "#{ex.message}",
          :error_class      => "#{ex.class}",
          :error_backtrace  => "#{ex.backtrace}"
        )

        raise
      end

    end

  end
end

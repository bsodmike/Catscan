module Catscan
  class Scan < ActiveRecord::Base
    self.table_name = "catscan_scans"

    attr_accessible :klass, :entity, :comment, :category,
      :error_message,
      :error_class,
      :error_backtrace
  end
end

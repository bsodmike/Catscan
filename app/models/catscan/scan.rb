module Catscan
  class Scan < ActiveRecord::Base
    self.table_name = "catscan_scans"

    serialize :payload
    attr_accessible :klass, :comment, :payload
  end
end

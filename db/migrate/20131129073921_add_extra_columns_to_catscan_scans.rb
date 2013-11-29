class AddExtraColumnsToCatscanScans < ActiveRecord::Migration
  def change
    add_column :catscan_scans, :entity, :string
    add_column :catscan_scans, :category, :string
    add_column :catscan_scans, :error_message, :string
    add_column :catscan_scans, :error_class, :string
    add_column :catscan_scans, :error_backtrace, :text
    remove_column :catscan_scans, :payload
  end
end

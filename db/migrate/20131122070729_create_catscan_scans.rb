class CreateCatscanScans < ActiveRecord::Migration
  def change
    create_table :catscan_scans do |t|
      t.string    :klass
      t.text      :payload
      t.string    :comment

      t.integer   :version,     :default => 1

      t.timestamps
    end
  end
end

class CreateCounters < ActiveRecord::Migration[7.0]
  def change
    create_table :counters do |t|
      t.string :name
      t.integer :number

      t.timestamps
    end
  end
end

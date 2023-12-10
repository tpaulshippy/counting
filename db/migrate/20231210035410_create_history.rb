class CreateHistory < ActiveRecord::Migration[7.1]
  def change
    create_table :histories do |t|
      t.references :counter, null: false, foreign_key: true
      t.integer :change

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class AddCreatedByToHistories < ActiveRecord::Migration[6.0]
  def change
    add_column :histories, :created_by, :integer
    add_foreign_key :histories, :users, column: :created_by
  end
end

# frozen_string_literal: true

class CreateJoinTableUserCounter < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :counters do |t|
      # t.index [:user_id, :counter_id]
      # t.index [:counter_id, :user_id]
    end
  end
end

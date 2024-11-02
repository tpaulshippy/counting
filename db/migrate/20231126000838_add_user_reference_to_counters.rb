# frozen_string_literal: true

class AddUserReferenceToCounters < ActiveRecord::Migration[7.1]
  def change
    add_reference :counters, :user, null: true, foreign_key: true
  end
end

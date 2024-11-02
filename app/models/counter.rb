# frozen_string_literal: true

class Counter < ApplicationRecord
  has_many :history, dependent: :destroy

  has_one :user
  has_and_belongs_to_many :users

  broadcasts_to ->(_counter) { :counters }

  def up(user_id, comment = nil)
    increment!(:number)
    save

    history.create(change: 1, comment:, created_by: user_id)
  end

  def down(user_id, comment = nil)
    decrement!(:number)
    save

    history.create(change: -1, comment:, created_by: user_id)
  end

  def reset(user_id, comment = nil)
    update(number: 0)

    history.create(change: 0, comment:, created_by: user_id)
  end
end

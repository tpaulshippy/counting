class Counter < ApplicationRecord
    has_many :history, dependent: :destroy

    has_one :user
    has_and_belongs_to_many :users

    broadcasts_to ->(counter) { :counters }

    def up(user_id)
        self.number += 1
        self.save

        self.history.create(change: 1, created_by: user_id)
    end

    def down(user_id)
        self.number -= 1
        self.save

        self.history.create(change: -1, created_by: user_id)
    end

    def reset(user_id)
        self.number = 0
        self.save

        self.history.create(change: 0, created_by: user_id)
    end

end

class Counter < ApplicationRecord
    has_many :history, dependent: :destroy

    broadcasts_to ->(counter) { :counters }

    def up
        self.number += 1
        self.save

        self.history.create(change: 1)
    end

    def down
        self.number -= 1
        self.save

        self.history.create(change: -1)
    end

    def reset
        self.number = 0
        self.save

        self.history.create(change: 0)
    end

end

class Counter < ApplicationRecord
    # after_update_commit { broadcast_replace_to "counters" }
    broadcasts_to ->(counter) { :counters }


    def up
        self.number += 1
        self.save
    end

    def down
        self.number -= 1
        self.save
    end

    def reset
        self.number = 0
        self.save
    end
end

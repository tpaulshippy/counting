class Counter < ApplicationRecord
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

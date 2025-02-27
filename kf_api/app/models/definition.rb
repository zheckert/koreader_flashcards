class Definition < ApplicationRecord
    belongs_to :flashcard

    validates :text, presence: true
end

class Flashcard < ApplicationRecord
  belongs_to :user
  has_one :definition, dependent: :destroy
end

class AddUniqueIndexToFlashcards < ActiveRecord::Migration[7.1]
  def change
    add_index :flashcards, [:user_id, :word], unique: true
  end
end

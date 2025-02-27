class AddFlashcardIdToDefinitions < ActiveRecord::Migration[7.1]
  def change
    add_column :definitions, :flashcard_id, :integer
  end
end

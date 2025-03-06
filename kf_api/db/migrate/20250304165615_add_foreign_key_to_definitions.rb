class AddForeignKeyToDefinitions < ActiveRecord::Migration[7.1]
  def change
    change_column_null :definitions, :flashcard_id, false
    add_foreign_key :definitions, :flashcards
    add_index :definitions, :flashcard_id
  end
end

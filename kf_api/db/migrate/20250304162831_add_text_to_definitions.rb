class AddTextToDefinitions < ActiveRecord::Migration[7.1]
  def change
    add_column :definitions, :text, :text
  end
end

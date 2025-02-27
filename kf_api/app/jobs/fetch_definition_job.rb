class FetchDefinitionJob < ApplicationJob
  queue_as :default

  def perform(flashcard_id)
    flashcard = Flashcard.find_by(id: flashcard_id)
    return unless flashcard # Skip if the flashcard is missing

    definition_text = DictionaryService.fetch_definition(flashcard.word)
    return unless definition_text # Skip if no definition is found

    flashcard.create_definition!(text: definition_text) # Creates a new Definition record
  end
end

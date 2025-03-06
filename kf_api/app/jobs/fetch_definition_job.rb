class FetchDefinitionJob < ApplicationJob
  queue_as :default
  
  # Retry up to 3 times, waiting 5 minutes between attempts
  retry_on StandardError, wait: 5.minutes, attempts: 3

  def perform(flashcard_id)
    Rails.logger.info "Starting FetchDefinitionJob for flashcard_id: #{flashcard_id}"
    
    flashcard = Flashcard.find_by(id: flashcard_id)
    if !flashcard
      Rails.logger.error "Flashcard not found with id: #{flashcard_id}"
      return
    end

    Rails.logger.info "Found flashcard with word: #{flashcard.word}"
    
    definition_text = DictionaryService.fetch_definition(flashcard.word)
    if !definition_text
      Rails.logger.error "No definition found for word: #{flashcard.word}"
      return
    end

    Rails.logger.info "Got definition text: #{definition_text}"
    
    definition = flashcard.definition || flashcard.build_definition
    if definition.update!(text: definition_text)
      Rails.logger.info "Successfully saved definition for word: #{flashcard.word}"
    else
      Rails.logger.error "Failed to save definition: #{definition.errors.full_messages.join(', ')}"
    end
  end
end

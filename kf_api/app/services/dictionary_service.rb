# Boilerplate service implementation for testing. todo: Make sure this is adequate.
require 'faraday'
require 'json'

class DictionaryService
  BASE_URL = "https://api.dictionaryapi.dev/api/v2/entries/en/"

  def self.fetch_definition(word)
    response = Faraday.get("#{BASE_URL}#{word}")
    return nil unless response.success?

    json = JSON.parse(response.body)
    json.dig(0, "meanings", 0, "definitions", 0, "definition") # Extract first definition
  rescue StandardError => e
    Rails.logger.error "Dictionary API Error: #{e.message}"
    nil
  end
end
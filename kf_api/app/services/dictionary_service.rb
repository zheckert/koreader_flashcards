# Boilerplate service implementation for testing. todo: Make sure this is adequate.
require 'faraday'
require 'json'

class DictionaryService
  BASE_URL = 'https://api.dictionaryapi.dev/api/v2/entries/en/'
  RATE_LIMIT_DELAY = 2 # seconds between requests

  #   https://dictionaryapi.dev/ todo: verify above link is correct

  def self.fetch_definition(word)
    # Add delay between requests to avoid rate limiting
    sleep(RATE_LIMIT_DELAY)

    response = Faraday.get("#{BASE_URL}#{word}")

    case response.status
    when 200
      Rails.logger.info 'API Response status: 200'
      json = JSON.parse(response.body)
      definition = json.dig(0, 'meanings', 0, 'definitions', 0, 'definition')
      Rails.logger.info "Found definition for #{word}: #{definition}"
      definition
    when 429 # Rate limited
      Rails.logger.warn 'Rate limited by dictionary API'
      raise 'Rate limited by dictionary API'
    else
      Rails.logger.error "API Error (#{response.status}): #{response.body}"
      nil
    end
  rescue JSON::ParserError => e
    Rails.logger.error "Failed to parse API response for word '#{word}': #{e.message}"
    nil
  rescue StandardError => e
    Rails.logger.error "Error fetching definition for '#{word}': #{e.message}"
    raise if e.message == 'Rate limited by dictionary API' # Re-raise rate limit errors

    nil
  end
end

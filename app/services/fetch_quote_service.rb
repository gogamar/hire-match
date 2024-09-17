class FetchQuoteService
  include HTTParty
  base_uri 'https://api.api-ninjas.com/v1'

  def initialize
    @api_key = ENV['API_NINJA_KEY']
  end

  def call
    options = {
      headers: {
        'X-Api-Key' => @api_key
      }
    }

    response = self.class.get('/quotes?category=success', options)

    if response.success?
      quote_data = response.parsed_response.first
      "#{quote_data['quote']} - #{quote_data['author']}"
    else
      "The best way to get started is to quit talking and begin doing. - Walt Disney"
    end
  rescue StandardError => e
    Rails.logger.error "Error fetching quote: #{e.message}"
    "The best way to get started is to quit talking and begin doing. - Walt Disney"
  end
end

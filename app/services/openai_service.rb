require 'httparty'

class OpenaiService
  include HTTParty
  base_uri 'https://api.openai.com/v1'

  def initialize(api_key)
    @api_key = api_key
  end

  def generate_reaction(prompt)
    full_prompt = "Say something positive about: #{prompt}"

    response = self.class.post('/chat/completions', {
      headers: {
        'Authorization' => "Bearer #{@api_key}",
        'Content-Type' => 'application/json'
      },
      body: {
        model: 'gpt-3.5-turbo', # Choose the appropriate model
        prompt: full_prompt,
        max_tokens: 10 # Adjust as needed
      }.to_json
    })

    if response.success?
      response.parsed_response['choices'].first['text'].strip
    else
      "Error: #{response.code} - #{response.message}"
    end
  end
end

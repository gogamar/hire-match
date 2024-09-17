class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :job_application
  validates :content, presence: true

  def generate_reaction(prompt)
    client = OpenAI::Client.new(api_key: ENV['OPENAI_API_KEY'])
    full_prompt = "React in a positive way to this phrase: #{prompt}"

    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: full_prompt }]
      }
    )

    if response["error"]
      puts "Error: #{response['error']['message']}"
      return nil
    end

    if response["choices"] && response["choices"][0] && response["choices"][0]["message"]
      return response["choices"][0]["message"]["content"]
    else
      puts "Unexpected response format: #{response.inspect}"
      return nil
    end
  end

end

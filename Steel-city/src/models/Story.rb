require "require_all"
require 'rest-client'
require 'json'

class Story < Sequel::Model
    def translate_text(source_text, target_language)
        endpoint = "https://api.cognitive.microsofttranslator.com/translate"
  
        params = {
            'api-version' => '3.0',
            'from' => 'en',
            'to' => target_language
        }

        body = [{
            'text' => source_text
        }]

        headers = {
            'Ocp-Apim-Subscription-Key' => 'cec2f32d171242dc88ca0a82e52ef50b',
            'Ocp-Apim-Subscription-Region' => 'uksouth',
            'Content-Type' => 'application/json'
        }

        response = RestClient.post(endpoint, body.to_json, headers)
        translation_data = JSON.parse(response.body)

        translation_data[0]['translations'][0]['text']
    end
end
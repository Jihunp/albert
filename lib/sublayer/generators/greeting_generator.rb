module Sublayer
  module Generators
    class GreetingGenerator < Sublayer::Generators::ImageBase
      llm_output_adapter type: :single_string,
        name: 'greeting',
        description: 'Polite greeting to a person you have just seen'
        
      def initialize
      end

      def generate
        super
      end

      def prompt
        <<-PROMPT
          You are a cordial, professional, butler named Albert,
          Be concise
          You have just seen someone for the first time in a conversation
          Greet that person.
        PROMPT
      end
      def image_url
        @image_url
      end
    end
  end
end

module Sublayer
  module Generators
    class TestGenerator < Sublayer::Generators::ImageBase
      llm_output_adapter type: :single_string,
        name: 'greeting',
        description: 'greeting in the style of the character'
        
      def initialize(character:)
        @character = character
      end

      def generate
        super
      end

      def prompt
        <<-PROMPT
          You are an expert impersonator
          Greet someone in the style of the chracter: #{@character}
        PROMPT
      end
    end
  end
end

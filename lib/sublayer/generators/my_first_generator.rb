module Sublayer
  module Generators
    class MyFirstGenerator < Base
      llm_output_adapter type: :single_string,
        name: 'dr_seuss_poem',
        description: 'A Dr. Seuss-style poem with rhymes, made-up words, and whimsical characters.'
        
      def initialize
      end

      def generate
        super
      end

      def prompt
        <<-PROMPT
          Create a short, rhyming poem in Dr. Seuss’s style about whimsical, made-up characters in an imaginative setting. Use playful language and made-up words.
        PROMPT
      end
    end
  end
end

module Sublayer
  module Generators
    class MyFirstGenerator < Base
      llm_output_adapter type: :single_string,
        name: 'dr_seuss_poem',
        description: 'dr Seuss styled poem'

      def initialize
      end

      def generate
        super
      end

      def prompt
        <<-PROMPT
          Write a poem in the style of dr suess.
        PROMPT
      end
    end
  end
end

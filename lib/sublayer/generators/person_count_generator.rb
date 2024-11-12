module Sublayer
  module Generators
    class PersonCountGenerator < Sublayer::Generators::ImageBase
      llm_output_adapter type: :single_string,
        name: 'person_count',
        description: 'integer of the number of people in the image'
        
        def initialize(image_url:)
          @image_url = image_url
        end

      def generate
        super
      end

      def prompt
        <<-PROMPT
          The image provided is an image of the room you are in.
          Please count the number of people in the room.
          return an integer
        PROMPT
      end
      def image_url
        @image_url
      end
    end
  end
end

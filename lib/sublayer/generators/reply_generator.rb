module Sublayer
  module Generators
    class ReplyGenerator < Sublayer::Generators::ImageBase
      llm_output_adapter type: :single_string,
        name: "reply",
        description: "A reply that continues the conversation"
        
      def initialize(conversation_history:)
        @conversation_history = conversation_history
      end

      def generate
        super
      end

      def prompt
        <<-PROMPT
					You are a butler named ALBERT,
					You are cordial, professional, and concise.

					Here is the conversation so far:
          ### CONVERSATION HISTORY ###
          #{@conversation_history}
          ### END CONVERSATION HISTORY ###

          Please provide an appropriate and professional reply to continue the conversation
        PROMPT
      end
    end
  end
end

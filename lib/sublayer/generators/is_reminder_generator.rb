#project_name/lib/sublayer/generators/is_reminder_generator.rb

module Sublayer
  module Generators
    class IsReminderGenerator < Sublayer::Generators::ImageBase
      llm_output_adapter type: :named_strings, #use the same name as before
        name: "is_a_reminder_request",
        description: "Evaluation of reminder.",
        attributes: [
          { name: "justification", description: "A clear brief explanation for why the message either qualifies or does not qualify as a reminder request." },
          { name: "is_a_reminder_request", description: "Boolean indicating if the message is a request for a reminder ('true' or 'false')." }
        ]

      def initialize(convo_history: "", message:)
        @convo_history = convo_history
        @message = message
      end
      
      # def initialize(message:)
      #   @message = message
      # end
      
      def generate
        super
      end

      
      def prompt
        <<-PROMPT
          Evaluate the most recent message.
          Determine if the most recent message is requesting a reminder. Provide:
          
          1. A justification for your conclusion in natural language.
          2. A boolean value ('true' or 'false') based on whether the message is a reminder request.
          
          current_history_context:
          #{@convo_history}
          
          Most recent message:
          #{@message}
        PROMPT
      end
    end
  end
end
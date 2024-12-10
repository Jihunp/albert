module Sublayer
  module Generators
    class ReminderAnalysisGenerator < Sublayer::Generators::ImageBase
      llm_output_adapter type: named_strings,
        name: "reminder_analysis",
        description: "the schedule and the content of a reminder",
	      attributes: [
	        { name: "schedule", description: "integer of the number of seconds until the reminder should be made" },
	        { name: "content", description: "the content of the reminder that should be made" },
	      ]
      def initialize(messages:)
        @message = message
      end

      def generate
        super
      end

      def prompt
        <<-PROMPT
          You are a polite, professional, and concise butler

          analyze the most_recent_message and extract the schedule in seconds that the requested reminder should be given

          also provide the content of the reminder that should be given at that time.

          conversation_history_context:
          #{@convo_history}

          most_recent_message:
          #{@message}
        PROMPT
      end
    end
  end
end

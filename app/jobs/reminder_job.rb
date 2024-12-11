class ReminderJob < ApplicationJob
  queue_as :default

  # def perform(convo:, channel_key:, messageo:)
  #   IsReminderGenerator.new(message: message).generate

  #   reminder = ReminderAnalysisGenerator.new(message: message).generate
  #   reminder.schedule
  #   reminder.content
  #   DelayedReminderHob.perform_in(reminder.schedule.to_i.seconds, content: content)
  # end

  def perform(convo:, channel_key:, message:)
    convo_history = convo.history

    result = Sublayer::Generators::IsReminderGenerator.new(convo_history: convo_history, message: message).generate
    is_reminder = result.is_a_reminder_request
    
    return unless is_reminder.downcase.strip == "true"

    analysis = Sublayer::Generators::ReminderAnalysisGenerator.new(convo_history: convo_history, message: message).generate

    ActualReminderJob.perform_in(analysis.schedule.to_i.seconds, analysis.content, channel_key)
  end
end
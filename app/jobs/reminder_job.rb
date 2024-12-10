class ReminderJob < ApplicationJob
  queue_as :default

  def perform
    isReminderGenerator.new(message: message).generate
    reminder = ReminderGenerator.new(message: message).generate
    reminder.schedule
    reminder.content

    "can you remind me in x amount of minutes I have a meeting soon."
  end
end
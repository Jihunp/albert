class Conversation < ApplicationRecord
  has_many :messages

  def history
    formatted_messages = messages.map { |m| "#{m.user}: #{m.content}" }
    formatted_messages.join("\n")
  end
end

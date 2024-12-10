class ReplyJob < ApplicationJob
  queue_as :default

  def perform(convo:, message:, channel_key:)
    convo.messages.create(content: message, user: "Edward")
    conversation_history = convo.history
    reply = Sublayer::Generators::ReplyGenerator.new(conversation_history: conversation_history).generate 
    
    convo.messages.create(user: "ALBERT", content: reply)
    ActionCable.server.broadcast(channel_key, reply)
  end

end
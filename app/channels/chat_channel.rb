class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from channel_key
  end

  def receive(data)
    if data['type'] == 'capture'
      handle_image(data)
    elsif data['type'] == 'send_message'
      handle_send_message(data)
    end
  end


  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end


  def handle_image(data)
    image_data = data['image']
    GreetingJob.perform_later(image_data: image_data, channel_key: channel_key)
  end

  def handle_send_message(data)
    current_convo = Conversation.last
    message = data['message']

    ReplyJob.perform_later(convo: current_convo, channel_key: channel_key, message: message)

    ReminderJob.perform_later() #we are going to check on this later

    # current_convo.messages.create(content: message, user: "Edward")

    # conversation_history = current_convo.history

    # reply = Sublayer::Generators::ReplyGenerator.new(conversation_history: conversation_history).generate 
    # current_convo.messages.create(user: "ALBERT", content: reply)
    
    # ActionCable.server.broadcast(channel_key, reply)
  end

  def channel_key
    "chat_channel_#{params[:room_id]}"
  end
end
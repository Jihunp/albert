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

    number_of_people = Sublayer::Generators::PersonCountGenerator.new(image_url: image_data).generate.to_i
    p number_of_people

    if number_of_people > 0
      greeting = Sublayer::Generators::GreetingGenerator.new.generate

      conversation = Conversation.create
      conversation.messages.create(content: greeting, user: "ALBERT")

      ActionCable.server.broadcast(channel_key, greeting)
    else
      ActionCable.server.broadcast(channel_key, "whistling~~~")
    end
  end

  def handle_send_message(data)
    current_convo = Conversation.last
    message = data['message']
    current_convo.messages.create(content: message, user: "Edward")

    conversation_history = current_convo.history

    p "COCONUTS"
    reply = Sublayer::Generators::ReplyGenerator.new(conversation_history: conversation_history).generate
    # 
    current_convo.messages.create(user: "ALBERT", content: reply)
    
    p reply
    ActionCable.server.broadcast(channel_key, reply)
  end

  def channel_key
    "chat_channel_#{params[:room_id]}"
  end
end
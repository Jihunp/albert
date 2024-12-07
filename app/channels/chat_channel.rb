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

    # number_of_people = Sublayer::Generators::PersonCountGenerator.new(image_url: image_data).generate.to_i
    # p number_of_people

    # if number_of_people > 0
    #   p "number of people is greater than 1"
    #   greeting = Sublayer::Generators::GreetingGenerator.new.generate

    #   p greeting

    #   conversation = Conversation.create

    #   puts "conversation"
    #   puts conversation

    #   conversationOfUser = conversation.messages.create(content: greeting, user: "ALBERT")
      
    #   puts conversationOfUser
    #   puts "check channel key"
    #   p channel_key

    #   # the error is in redis database. It is definetly picking up the wrong database

    #   ActionCable.server.broadcast(channel_key, greeting)
    # else
    #   ActionCable.server.broadcast(channel_key, "whistling~~~")
    # end
  end

  def handle_send_message(data)
    current_convo = Conversation.last
    message = data['message']
    current_convo.messages.create(content: message, user: "Edward")

    conversation_history = current_convo.history

    reply = Sublayer::Generators::ReplyGenerator.new(conversation_history: conversation_history).generate 
    current_convo.messages.create(user: "ALBERT", content: reply)
    
    p reply
    ActionCable.server.broadcast(channel_key, reply)
  end

  def channel_key
    "chat_channel_#{params[:room_id]}"
  end
end
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params[:room_id]}"
  end

  def receive(data)
    if data['type'] == 'capture'
      image_data = data['image']

      number_of_people = Sublayer::Generators::PersonCountGenerator.new(image_url: image_data).generate.to_i
      p number_of_people

      if number_of_people > 0
        greeting = Sublayer::Generators::GreetingGenerator.new.generate
        p greeting

        ActionCable.server.broadcast("chat_channel_#{params[:room_id]}", greeting)
      else
        ActionCable.server.broadcast("chat_channel_#{params[:room_id]}", "whistling~~~")
      end
    elsif data['type'] == 'send_message'
      puts "send a message"
    end
  end


  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

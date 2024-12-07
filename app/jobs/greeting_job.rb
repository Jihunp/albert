class GreetingJob < ApplicationJob
  queue_as :default

  def perform(image_data:, channel_key:)
    p "WE are in background job"
    number_of_people = Sublayer::Generators::PersonCountGenerator.new(image_url: image_data).generate.to_i
    p number_of_people

    if number_of_people > 0
      p "number of people is greater than 1"
      greeting = Sublayer::Generators::GreetingGenerator.new.generate

      p greeting

      conversation = Conversation.create

      puts "conversation"
      puts conversation

      conversationOfUser = conversation.messages.create(content: greeting, user: "ALBERT")
      
      puts conversationOfUser
      puts "check channel key"
      p channel_key

      # the error is in redis database. It is definetly picking up the wrong database

      ActionCable.server.broadcast(channel_key, greeting)
    else
      ActionCable.server.broadcast(channel_key, "whistling~~~")
    end
  end

end
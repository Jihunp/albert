class GreetingJob < ApplicationJob
  queue_as :default

  def perform(image_data:, channel_key:)
    number_of_people = Sublayer::Generators::PersonCountGenerator.new(image_url: image_data).generate.to_i
    if number_of_people > 0
      greeting = Sublayer::Generators::GreetingGenerator.new.generate
      conversation = Conversation.create
      conversation.messages.create(content: greeting, user: "ALBERT")
      
      ActionCable.server.broadcast(channel_key, greeting)
    else
      ActionCable.server.broadcast(channel_key, "whistling~~~")
    end
  end

end
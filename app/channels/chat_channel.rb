class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params[:room_id]}"
  end

  def receive(data)
    image_data = data['image']
    p image_data
    p "success"
    # later handles screenshot data
  end
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

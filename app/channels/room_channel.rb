class RoomChannel < ApplicationCable::Channel
  def subscribed
    Room.all.each do |room|
      stream_from "room_channel_#{room.id}"
    end
  end

  def unsubscribed
    stop_all_streams
  end

  def speak(data)
    Message.create! content: data['message'],
                    user: User.first,
                    room: Room.first
  end
end

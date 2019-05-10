class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    room_id = message.room.id

    ActionCable.server.broadcast "room_channel_#{room_id}",
      message: render_message(message),
      room_id: message.room.id
  end

  private

  def render_message(message)
    ApplicationController.renderer.render( partial: 'messages/message',
                                           locals: { message: message })
  end
end

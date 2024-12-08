class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params[:room_id]}"
    Rails.logger.info "Subscribed to room #{params[:room_id]}"
  end

  def unsubscribed
  end

  def start_quiz(data)
    ActionCable.server.broadcast("room_#{data['room_id']}", { event: 'start_quiz' })
  end
end

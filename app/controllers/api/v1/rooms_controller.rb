class Api::V1::RoomsController < Api::V1::BaseController
  def create
    joining_code = rand(100000..999999)
    @room = current_user.created_rooms.create(quiz_id: params[:quiz_id], status: :is_open, joining_code: joining_code)
    @room.users << current_user
  end

  def show
    @room = Room.find(params[:id])
  end

  def join
    @room = Room.find_by(joining_code: params[:joining_code])

    room_user = @room.room_users.find_or_create_by(user_id: current_user.id)
    room_user.update(status: :active)

    # ActionCable.server.broadcast("room_#{@room.id}", { event: 'new_user_joined', user: current_user.as_json })
    # HTTParty.post('https://golden-vast-mongoose.ngrok-free.app/rooms/joined', body: { user: current_user, room: @room }.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def leave
    @room = Room.find(params[:id])

    room_user = @room.room_users.find_by(user_id: current_user.id)
    room_user.update(status: :inactive) if room_user.present?

    render json: { success: true, message: 'You have successfully left this room' }
  end

  def scoreboard
    @room = Room.find(params[:id])

    HTTParty.post('https://golden-vast-mongoose.ngrok-free.app/rooms/refresh_scoreboard', body: { user: current_user, room: @room, scoreboard: @room.scoreboard }.to_json, headers: { 'Content-Type' => 'application/json' })
    render json: { scoreboard: @room.scoreboard }, status: :ok
  end
end

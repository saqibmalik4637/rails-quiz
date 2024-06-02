class Api::V1::RoomsController < Api::V1::BaseController
  def create
    joining_code = rand(999999)
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

    HTTParty.post('https://tender-penguin-75.telebit.io/rooms/joined', body: { user: current_user, room: @room }.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  def leave
    @room = Room.find(params[:id])

    room_user = @room.room_users.find_by(user_id: current_user.id)
    room_user.update(status: :inactive) if room_user.present?

    render json: { success: true, message: 'You have successfully left this room' }
  end
end

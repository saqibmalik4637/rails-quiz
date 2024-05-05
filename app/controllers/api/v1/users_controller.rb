class Api::V1::UsersController < Api::V1::BaseController
  skip_before_action :authenticate_user, only: [:create]

  def me;end

  def create
    @user = User.create!(user_params)
    @user.update(username: "guest-user-#{@user.id}");
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :age, :country_code)
  end
end

class Api::V1::UsersController < Api::V1::BaseController
  def me

  end

  def create
    @user = User.create!(user_params)
    @user.update(username: "guest-user-#{@user.id}");
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :age, :country_code)
  end
end

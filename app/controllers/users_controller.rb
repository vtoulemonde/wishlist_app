class UsersController < ApplicationController

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Your account has been created! Please login."
      redirect_to root_path
    else
      render "sessions/index"
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
      )
  end

end

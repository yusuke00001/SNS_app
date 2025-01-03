class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:notice] = t('flash.users.create.success')
      redirect_to login_path
    else
      flash.now[:alert] =  user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

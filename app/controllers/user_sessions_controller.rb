class UserSessionsController < ApplicationController
  def new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      flash[:notice] = t('flash.user_sessions.create.success')
      redirect_to posts_path
    else
      flash.now[:alert] = t('flash.user_sessions.create.error')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:notice] = t('flash.user_sessions.destroy.logout')
    redirect_to login_path
  end
end

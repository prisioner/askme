class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.authenticate(email: params[:email], password: params[:password])

    if @user.present?
      session[:user_id] = @user.id
      redirect_to root_url, notice: I18n.t('pages.sessions.new.success')
    else
      flash.now.alert = I18n.t('pages.sessions.new.error')
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: I18n.t('main.logged_out')
  end
end

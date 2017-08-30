class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(email: params[:email], password: params[:password])

    if user.present?
      session[:user_id] = user.id
      redirect_to root_url, notice: I18n.t('controllers.sessions.created')
    else
      flash.now.alert = I18n.t('controllers.sessions.create_error')
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: I18n.t('controllers.sessions.destroyed')
  end
end

class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build
  end

  def new
    redirect_to root_path, alert: I18n.t('pages.users.new.already_logged_in') if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_path, alert: I18n.t('pages.users.new.already_logged_in') if current_user.present?

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: I18n.t('pages.users.new.user.created')
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: I18n.t('pages.users.edit.user.saved')
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to root_path, notice: I18n.t('pages.users.edit.account_deleted')
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url, :avatar_bg_color,
                                 :avatar_border_color, :profile_text_color)
  end
end

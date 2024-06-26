class UsersController < ApplicationController
  load_and_authorize_resource
  def new
    @user = User.new
  end

  def show;  end

  def edit;  end

  def update
    if @user.update(user_params.except(:email))
      flash[:success] = t("update.success_message")
      redirect_to user_path
    else
      flash.now[:error] = t("update.error_message")
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t("sign_up.success")
      redirect_to static_pages_home_path
    else
      flash.now[:error] = t("sign_up.error")
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit User::ATTRIBUTES
  end

  def user_not_found
    flash[:danger] = t "users.flash.user_not_found"
    redirect_to root_path
  end
end

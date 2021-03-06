class UsersController < ApplicationController
  before_action :set_user, only: :update
  before_action :user_logged_in, only: :forgot_password

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(recover_code: params[:id]) if !params[:id].nil?
    redirect_to new_session_path, notice: "Incorrect recovery code." if @user.nil?
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in(@user)
        format.html { redirect_to sample_home_index_path, notice: "User was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params.merge(recover_code: nil))
        log_in(@user)
        format.html { redirect_to sample_home_index_path, notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def forgot_password
    @user = User.new
    if request.post?
      if User.forgot_password(user_params[:email])
        redirect_to new_session_path, notice: "Recovery email has been sent"
      else
        redirect_to new_session_path, notice: "Email could not be sent"
      end
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_logged_in
      redirect_to sample_home_index_path if current_user
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end

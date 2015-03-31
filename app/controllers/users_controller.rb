class UsersController < ApplicationController
  before_action :must_be_logged_in, except: [ :new, :create ]
  before_action :must_be_logged_out, only: [ :new, :create ]
  before_action :must_be_correct_user, only: [ :edit, :update, :destroy, :show ]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @studies = Study.all
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Signed up! Thank you! 
        You should receive a validation email shortly."
      @user.send_validation
      redirect_to users_url
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user, notice: "Profile updated!"
    else
      render 'edit'
    end
  end

  def destroy
    destroying_self = current_user.id.to_s == params[:id]
    was_admin_user = is_admin_user?
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    if was_admin_user && !destroying_self
      redirect_to users_url
    else
      redirect_to root_url
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password,
         :password_confirmation, :name, :address_line_one, 
         :address_line_two, :city, :state, :zip_code, 
         :auth_token, :password_reset_token )
    end

    def must_be_logged_out
      if logged_in? && !is_admin_user?
        redirect_to root_url, notice: "You already have an account."
      end
    end

    def must_be_correct_user
      if !is_admin_user?
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
      end
    end
end

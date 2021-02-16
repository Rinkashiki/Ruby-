 class UsersController < ApplicationController

  layout 'in_session', only: [ :index, :edit]

  skip_before_action :authorized, only: [ :new, :create]

  before_action :set_user, only: [ :edit, :update, :show, :destroy]

  def index
    @users = User.all
  end

  # New user sign up by himself/herself. The assign profile is the default one (User)
  def new
    @user = User.new
    @profiles = Profile.all
    if logged_in?
      render layout: "in_session"
    end
  end

  def create
    if !params[ :user][ :profile].nil?
      @profile = Profile.find_by_name(params[ :user][ :profile])
    else
      @profile = Profile.find_by_name('Usuario')
    end
    @user = @profile.users.new user_params
    @user[ :password] = SecureRandom.hex
    
    if @user.save
      UserMailer.with(user: @user).new_user_email.deliver_later
      flash[ :alert] = 'Succesfully registered!'
      redirect_to '/welcome'
    else
      flash[ :alert] = @user.errors.first.full_message
      redirect_to new_user_path
    end
  end

  def show
  end

  def edit
    @profiles = Profile.all
  end

  def update
    @profile = Profile.find_by_name(params[ :user][ :profile])

    @user[ :profile_id] = @profile[ :id]
    @user.update user_params

    flash[ :alert] = 'Succesfully edited!'

    redirect_to users_path
  end

  def destroy
    @user.destroy
    flash[ :alert] = 'Successfully deleted user'
    redirect_to users_path
  end


  private

  def user_params
    params.require( :user).permit( :name, :surname, :email)    
  end

  def set_user
    @user = User.find params[ :id]
  end

end

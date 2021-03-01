class ApplicationController < ActionController::Base

  before_action :authorized
  helper_method :current_user
  helper_method :logged_in?

  def current_user    
    User.find_by(id: session[:user_id])  
  end

  def logged_in?    
    !current_user.nil?  
  end

  def authorized
    redirect_to '/welcome' unless logged_in?
  end

  rescue_from ActionController::ParameterMissing do |e|
    flash[ :alert] = 'Video not attached'
    redirect_to new_clip_path
  end

end

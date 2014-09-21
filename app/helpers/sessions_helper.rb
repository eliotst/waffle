module SessionsHelper
  def log_in(user)
    auth_token = User.new_auth_token
    cookies.permanent[:auth_token] = auth_token
    user.update_attribute(:auth_token, User.digest(auth_token))
    self.current_user = user
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    if @current_user == nil
      auth_token = User.digest(cookies[:auth_token])
      @current_user ||= User.find_by(auth_token: auth_token)
    end
    @current_user
  end

  def current_user?(user)
    user == current_user
  end

  def current_question=(question)
    @current_question = question
  end

  def current_question?(question)
    question == current_question
  end

  def log_out
    current_user.update_attribute(:auth_token, User.digest(User.new_auth_token))
    cookies.delete(:auth_token)
    self.current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def is_admin_user?
    !current_user.nil? && current_user.admin?
  end
end

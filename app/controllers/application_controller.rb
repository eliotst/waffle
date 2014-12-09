class ApplicationController < ActionController::Base
  include SessionsHelper
  helper_method :current_user
  after_filter :csrf

  #Before filters
  def must_be_logged_in
    if !logged_in?
      store_location
      redirect_to log_in_url, notice: "Please log in."
    end
  end

  def must_be_admin
    redirect_to(root_url) unless is_admin_user?
  end

  def csrf
    response.header['X-CSRF-Token'] = form_authenticity_token
  end
end

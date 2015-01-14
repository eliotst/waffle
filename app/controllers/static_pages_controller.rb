class StaticPagesController < ApplicationController
  def home
    if !current_user.nil?
      redirect_to current_user
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end

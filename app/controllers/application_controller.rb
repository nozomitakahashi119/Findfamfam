class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(house)
    @counts_houses = user.houses.count
    @counts_requestings = user.requestings.count
  end
  
end
module SessionsHelper
  
  #ログインしているユーザーを探す
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  #今ログインしているか
  def logged_in?
    !!current_user
  end
  
end
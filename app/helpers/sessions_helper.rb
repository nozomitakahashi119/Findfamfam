module SessionsHelper
  
  #ログインしているユーザーを探す
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  #今ログインしているか
  def logged_in?
    !!current_user
  end
  
  #本人かどうか確認
  def current_user?(user)
    user == current_user
  end
  
  #募集を作成したユーザーを探す（うまくいかず使っていない）
  def maked_user
    @maked_user ||= User.find_by(id: session[:user_id]) && House.find_by(id: house_id)
  end
  
end
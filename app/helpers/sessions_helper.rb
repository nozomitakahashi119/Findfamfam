module SessionsHelper
  
  #ログインしているユーザーを探す
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  #募集を作成したユーザーを探す
  def maked_user
    @maked_user ||= User.find_by(id: session[:user_id]) && House.find_by(id: house_id)
  end
  
  #自分自身以外を探すユーザー
  def ather_user
    User.where.not(id: current_user.id)
  end
  
  #今ログインしているか
  def logged_in?
    !!current_user
  end
  
end
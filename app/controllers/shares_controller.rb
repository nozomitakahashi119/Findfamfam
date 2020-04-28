class SharesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    house = House.find(params[:house_id])
    current_user.request(house)
    flash[:success] = '同居申請をしました。'
    redirect_to houses_path
  end

  def destroy
    house = House.find(params[:house_id])
    current_user.unrequest(house)
    flash[:success] = '同居申請を取り消しました'
    redirect_to houses_path
  end
  
  def permit_share  #users_controllerにこちらのメソッドを書いても同様の動きをした
    puts "OK,ここを見ろ！！！！！"
    p params
    share = Share.where(user_id: params[:user_id])
                 .where(house_id: params[:house_id])
    if share
      share.update(ok_request: true)
      flash[:success] = '申請を許可しました。'
    end
    redirect_to house_path(params[:house_id])
  end
  
  def unpermit_share  #users_controllerにこちらのメソッドを書いても同様の動きをした
    
    share = Share.where(user_id: params[:user_id])
                 .where(house_id: params[:house_id])
    if share
      share.update(ok_request: false)
      flash[:success] = '許可を取り消しました。'
    end
    redirect_to house_path(params[:house_id])
  end
  
end

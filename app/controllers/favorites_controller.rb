class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    puts "ここだよ"
    house = House.find(params[:like_id])
    current_user.like(house)
    flash[:success] = '募集をお気に入りにしました。'
    redirect_back(fallback_location: houses_path)
    puts "ここだよ"
    #redirect_to house_path(house)
  end

  def destroy
    house = House.find(params[:like_id])
    current_user.unlike(house)
    flash[:success] = '募集をお気に入りから解除しました。'
    redirect_back(fallback_location: houses_path)
    #redirect_to house_path(house)
  end
end

class HousesController < ApplicationController
  before_action :require_user_logged_in #ログインしてるユーザーしか触れない
  before_action :correct_user, only: [:destoroy]
  
  def index
    if logged_in?
      @house = current_user.houses.build #form_with用
      @houses = current_user.houses.order(id: :desc).page(params[:page])
    end
  end

  def show
    @house = House.find(params[:id])
  end
  
  def new
    @house = current_user.houses.build
  end

  def create
    @house = current_user.houses.build(house_params) #()は下のprivateで定義
    if @house.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to houses_path
    else
      @houses = current_user.houses.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'houses/new'
    end
  end

  def destoroy
    @house.destoroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def house_params
    params.require(:house).permit(:title, :place, :room_size, :rent, :gender, :special_notes)
  end
  
end

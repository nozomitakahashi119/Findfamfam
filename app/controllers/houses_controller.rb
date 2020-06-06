class HousesController < ApplicationController
  before_action :require_user_logged_in #ログインしてるユーザーしか触れない
  before_action :correct_user, only: [:destoroy]
  
  def index
    if logged_in?
      @house = current_user.houses.build #form_with用
      @houses = House.order(id: :desc).page(params[:page]).per(15) #ハウスクラス全体の募集の表示
    end
  end
  
  def my_index
    if logged_in?
      @house = current_user.houses.build #form_with用
      @houses = current_user.houses.order(id: :desc).page(params[:page]).per(15) #自分の投稿の一覧表示
      render :index #houses/index.html.erbへの遷移を指定
    end
  end
  
  def my_request_index
    if logged_in?
      @house = current_user.houses.build #form_with用
      @houses = Share.where(user_id: current_user).page(params[:page]).per(15) #自分が申請した一覧表示
      render :request_index #houses/request_index.html.erbへの遷移を指定
    end
  end
  
  def my_like_index
    if logged_in?
      @house = current_user.houses.build #form_with用
      @houses = current_user.likes.order(id: :desc).page(params[:page]).per(15) #自分の投稿の一覧表示
      render :index #houses/index.html.erbへの遷移を指定
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
      flash[:success] = '同居募集を投稿しました。'
      redirect_to houses_path
    else
      @houses = current_user.houses.order(id: :desc).page(params[:page])
      flash.now[:danger] = '同居募集の投稿に失敗しました。'
      render 'houses/new'
    end
  end

  def destoroy
    @house.destoroy
    flash[:success] = '同居募集を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def house_params
    params.require(:house).permit(:title, :place, :room_size, :rent, :gender, :special_notes)
    #params.permit(:title, :place, :room_size, :rent, :gender, :special_notes)
  end
  
end
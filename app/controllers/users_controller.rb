class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit] #ログインユーザーしか触れない
  before_action :correct_user, only: [:edit, :update]
  
  def index
    #マイホーム、各ページへのリンクがある
  end
  
  def to_do_list
    #これからのやることリストのページ
  end

  def show
    @user = User.find(params[:id])
    #プロフィールのページへ遷移
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) #user_paramsは下のprivateで定義
    
    if @user.save
      flash[:success] = 'ユーザーを登録しました。'
      redirect_to root_path
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
    
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if current_user == @user
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を更新しました。'
        redirect_to root_path
      else
        flash.now[:danger] = 'ユーザー情報を更新できませんでした'
        render :edit
      end
    else
      redirect_to root_path
    end
    
  end
  
  #shares_controllerにあるdef permit_shareをこちらに書いても同様の動きをした
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :gender, :income, :hobby, :special_notes )
  end

  # 本人と違うとすれば一覧に遷移
  def correct_user
    @user = User.find(params[:id])
    redirect_to(houses_path) unless current_user?(@user)
  end

end
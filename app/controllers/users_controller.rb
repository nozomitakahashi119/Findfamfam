class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    #@houses = House.order(id: :desc).page(params[:page]).per(25)
    #マイホーム、各ページへのリンクがある
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
  end
end

private

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end

class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :houses #募集との紐付け
  has_many :shares #許可テーブルとの紐付け
  
  
  has_many :requestings, through: :shares, source: :house #リクエストしている募集の取得
  has_many :reverses_of_share, class_name: 'Share', foreign_key: 'ok_request' #自分の募集にリクエストしてくれているユーザーへの参照
  #has_many :requesters, through: reverses_of_share, source: :share #自分の募集にリクエストしてくれているユーザー達
  
  def request(house) #申請する動き
    self.shares.find_or_create_by(house_id: house.id)
  end
  
  def unrequest(house) #申請を取り消す動き
    request = self.shares.find_by(house_id: house.id)
    request.destroy if request
  end
  
  def requesting?(house) #申請してるかの確認
    self.requestings.include?(house)
  end
  
=begin ここのメソッドはsharesコントローラーに記載している

  def ok_request(house) #申請を許可（ok_requestカラムに記入）
    self.shares.find_or_create_by(ok_request: "1")
  end
  
  def not_request(house) #申請許可したことを取り消す（ok_requestカラムの訂正）
    share = self.shares.find_by(ok_request: shares.id)
    share.destroy if share
=end

  #has_many :ok_requestings, through: :houses, source: :shares #許可している募集の取得
  has_many :ok_requestings, through: :shares, :foreign_key => 'ok_request', source: :house
  
  def ok_request?(house) #申請してるかの確認
    self.ok_requestings.include?(house)
  end
  
  def permitted_appliments?(house)
    return self.shares.where(ok_request: 1)
  end

  
  def permit_share?(house) #申請してるかの確認
    count = self.shares.where(ok_request: 1).count
    return count > 0
  end
  
  def permit_share?(zero="0") #申請してるかの確認
    count = Share.where(ok_request: true).count
    count > 0 ? count.to_s : zero
  end
  
  
  has_many :favorites
  has_many :likes, through: :favorites, source: :like
  
  def like(house)
    self.favorites.find_or_create_by(like_id: house.id) 
  end

  def unlike(house)
    like = self.favorites.find_by(like_id: house.id)
    like.destroy if like
  end
  
  def like?(house)
    self.likes.include?(house)
  end

end
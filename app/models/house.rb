class House < ApplicationRecord
  belongs_to :user #ユーザーの紐付け
  has_many :shares #許可テーブルとの紐付け
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :place, presence: true, length: { maximum: 50 }
  validates :room_size, presence: true, length: { maximum: 50 }
  validates :rent, presence: true, length: { maximum: 50 }
  validates :gender, presence: true, length: { maximum: 50 }
  validates :special_notes, presence: true, length: { maximum: 255 }
  
end
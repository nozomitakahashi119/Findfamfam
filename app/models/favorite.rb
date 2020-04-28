class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :like, class_name: 'House'
end

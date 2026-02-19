class Comment < ApplicationRecord

  # バリデーション
  validates :content, presence: true

  # アソシエーション
  belongs_to :prototype  # prototypeテーブルとのアソシエーション
  belongs_to :user       # usersテーブルとのアソシエーション
end

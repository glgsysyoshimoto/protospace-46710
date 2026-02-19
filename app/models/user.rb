class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # Devise
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーション
  validates :name, presence: true
  validates :profile, presence: true
  validates :position, presence: true

  # アソシエーション
  has_many :prototypes  # prototypesテーブルとのアソシエーション
  has_many :comments    # commentsテーブルとのアソシエーション
end

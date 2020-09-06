class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "following_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :follower
  has_many :followers, through: :passive_relationships, source: :following
  attachment :profile_image
  validates :name, presence: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

   # ユーザーをフォローする
 #followed_idにother_userを追加
  def follow(other_user)
    active_relationships.create(follower_id: other_user.id)
  end

# ユーザーをフォロー解除する
  # followed_idを削除
  def unfollow(other_user)
    active_relationships.find_by(follower_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
end
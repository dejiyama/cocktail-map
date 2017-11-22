class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :cocktailposts
  has_many :relationships
  has_many :favorites
  has_many :favorite_cocktailposts, through: :favorites, source: :cocktailpost
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  def follow(other_user)
    unless self == other_user
    self.relationships.find_or_create_by(follow_id: other_user.id)
   end
 end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def followings?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_cocktailposts
    Cocktailpost.where(user_id: self.following_ids + [self.id])
  end
  
  def favorite(cocktailpost)
    self.favorites.find_or_create_by(cocktailpost_id: cocktailpost.id)
  end
 
  
  def unfavorite(cocktailpost)
    favorite = self.favorites.find_by(cocktailpost_id: cocktailpost.id)
    favorite.destroy if favorite
  end
  
  def favoriting?(cocktailpost)
    favorite_cocktailposts.include?(cocktailpost)
  end
end
    
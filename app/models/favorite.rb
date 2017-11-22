class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :cocktailpost
  
  validates :user_id, presence: true
  validates :cocktailpost_id, presence: true
end

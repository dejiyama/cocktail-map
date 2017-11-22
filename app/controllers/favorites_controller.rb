class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    cocktail = Cocktailpost.find(params[:cocktailpost_id])  
    current_user.favorite(cocktail)
    flash[:success] = 'お気に入りに追加しました。'
    redirect_to current_user
  end

  def destroy
    cocktail = Cocktailpost.find(params[:cocktailpost_id])
    current_user.unfavorite(cocktail)
    flash[:success] = 'お気に入りを解除しました。'
    redirect_to current_user
  end
end

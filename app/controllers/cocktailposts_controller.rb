class CocktailpostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @cocktailpost = current_user.cocktailposts.build(cocktailpost_params)
    if @cocktailpost.save
      flash[:success] = 'レシピをシェアしました。'
      redirect_to root_url
    else
      @cocktailposts = current_user.feed_cocktailposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'レシピのシェアに失敗しました。'
      render 'toppages/index'
  end
end


  def destroy
    @cocktailpost.destroy
    flash[:success] = 'レシピを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def cocktailpost_params
    params.require(:cocktailpost).permit(:content)
  end
  
  def correct_user
    @cocktailpost = current_user.cocktailposts.find_by(id: params[:id])
    unless @cocktailpost
    redirect_to root_url
   end
  end
end

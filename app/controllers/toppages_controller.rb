class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @cocktailpost = current_user.cocktailposts.build
      @cocktailposts = current_user.feed_cocktailposts.order('created_at DESC').page(params[:page])
    end
  end
end

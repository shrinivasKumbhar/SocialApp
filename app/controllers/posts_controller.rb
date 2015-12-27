class PostsController < ApplicationController
  
  def show
    Rails.logger.info{"#{__FILE__}: #{__LINE__} show action start"}
    @user = User.find_by_id(params[:id])
    @posts = Post.where(:user_id => params[:id]).order(created_at: :desc)
    @friends = User.limit(10)
    Rails.logger.info{"#{__FILE__}: #{__LINE__} show action end"}
  end
  def create
    Rails.logger.info{"#{__FILE__}: #{__LINE__} create actio start"}
      render :json => Post.new.create_post(params)
    Rails.logger.info{"#{__FILE__}: #{__LINE__} create actio end"}
  end
end

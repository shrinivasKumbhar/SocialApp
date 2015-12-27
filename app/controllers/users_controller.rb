class UsersController < ApplicationController
  def index
    Rails.logger.info{"#{__FILE__}: #{__LINE__} index action start"}
      @user = User.new  
    Rails.logger.info{"#{__FILE__}: #{__LINE__} index action end"}
  end
  
  def create
    Rails.logger.info{"#{__FILE__}: #{__LINE__} create action start"}
    response = User.new.create_user(params)
    if response[:success] == true
      redirect_to users_path
    else
      redirect_to controller: 'users', action: 'index'
    end
    Rails.logger.info{"#{__FILE__}: #{__LINE__} create action end"}    
  end
  
  def login
    Rails.logger.info{"#{__FILE__}: #{__LINE__} login action start"}
      response = User.new.user_login(params)
      if response[:success] == true
        redirect_to controller: 'posts', action: 'show', id: response[:data].id
      else
        redirect_to users_path
      end
    Rails.logger.info{"#{__FILE__}: #{__LINE__} login action end"}
  end
  
  def search_friend
    Rails.logger.info{"#{__FILE__}: #{__LINE__} search_friend action start"}
      render :json => User.new.search_user_friend(params)
    Rails.logger.info{"#{__FILE__}: #{__LINE__} search_friend action end"}
  end
end

class User < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  has_many :post
  validates :name, presence: true
  validates :email, presence: true
  validates :mobile_no, presence: true
  validates :gender, presence: true
  validates :address, presence: true
  
  def create_user(params)
    Rails.logger.info{"#{__FILE__}: #{__LINE__} create_user method start"}
    begin
      user = User.new(
        name: params[:user][:name],
        email: params[:user][:email],
        mobile_no: params[:user][:mobile_no],
        gender: params[:user][:gender],
        address: params[:user][:address],
        password: params[:user][:password],
        photo: params[:user][:photo]
        )
        if user.save
          response = {:success => true, :data => user}
        else
          Rails.logger.error{"#{__FILE__}: #{__LINE__} Exception : #{user.errors.full_messages.join(', ')+'.'}"}
          response = {:success => false, :message => user.errors.full_messages.join(', ')+'.'}    
        end
    rescue => e
      Rails.logger.error{"#{__FILE__}: #{__LINE__} Exception : #{e.message}"}
      response = {:success => false, :message => "Internal Server Server, Please try again"}
    end
    Rails.logger.info{"#{__FILE__}: #{__LINE__} create_user method end"}
    return response
  end
  
  def user_login(params)
    Rails.logger.info{"#{__FILE__}: #{__LINE__} user_login method start"}
    begin
      user = User.where(:email => params[:user][:email], :password => params[:user][:password]).first
      if user.present?
        response = {:success => true, :data => user}
      else
        reponse = {:success => false, :message => "Invalid Email or Password."}
      end
    rescue => e
      Rails.logger.error{"#{__FILE__}: #{__LINE__} Exception : #{e.message}"}
      response = {:success => false, :message => e.message}
    end
    Rails.logger.info{"#{__FILE__}: #{__LINE__} user_login method end"}
    return response
  end
  
  def search_user_friend(params)
    Rails.logger.info{"#{__FILE__}: #{__LINE__} search_user_friend method start"}
    begin
      if params.present?
        users = User.where("name like '%#{params[:search_text]}%'")
        if users.present?
          friend_list = []
          users.each do |user|
            friend = Friend.where("(user_id = #{params[:user_id]} AND friend_id = #{user.id}) OR (user_id = #{user.id} AND friend_id = #{params[:user_id]})").first
            if !friend.present?
                friend_list.push(user)         
            end  
          end
          response = {:success => true, :data => friend_list}
        else
          response = {:success => false, :message => "No users present."}
        end
      else
        response = {:success => false, :message => "Parameters not present."}
      end
    rescue => e
      Rails.logger.error{"#{__FILE__}: #{__LINE__} Exception : #{e.message}"}
      response = {:success => false, :message => "Internal server error, please try again."}
    end
    Rails.logger.info{"#{__FILE__}: #{__LINE__} search_user_friend method end"}
    return response
  end
end

class Post < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  belongs_to :user
  
  def create_post(params)
    Rails.logger.info{"#{__FILE__}: #{__LINE__} create_post method start"}
    begin
      if params.present?
        if params[:post][:category].to_s == "Photo"
          post = Post.new(
            user_id: params[:post][:user_id],
            category: params[:post][:category],
            photo: params[:post][:photo]
          )    
        else
          post = Post.new(
            user_id: params[:post][:user_id],
            category: params[:post][:category],
            description: params[:post][:description]
          )
        end  
        if post.save
          response = {:success => true, :data => post}
        else
          response = {:success => false, :message => post.errors.full_messages.join(', ')+'.'}
        end
      else
        response ={:success => false, :message => "No paramenter found."}
      end
    rescue => e
      Rails.logger.error{"#{__FILE__}: #{__LINE__} Exception : #{e.message}"}
      response = {:success => false, :message => "Internal server error, please try again."}
    end
    Rails.logger.info{"#{__FILE__}: #{__LINE__} create_post method end"}
    return response
  end
end

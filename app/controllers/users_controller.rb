class UsersController < ApplicationController
  
  def index
    user = User.find_by(uid: current_user.uid)
    @avatar = user.return_avatar
    @stars = user.return_star_count
    @followers =  user.return_followers_count
    @following = user.return_following_count
  end
  
end
class PagesController < ApplicationController
  
  def index
    user = User.find_by(uid: current_user.uid)
    @following_activity = user.return_following_activity
  end
  
end
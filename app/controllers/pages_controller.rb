class PagesController < ApplicationController
  
  def index
    user = User.find_by(uid: current_user.uid)
    @following_activity = user.return_following_activity
    @mentions = user.return_mentions
  end
  
end
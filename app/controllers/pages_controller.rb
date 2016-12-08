class PagesController < ApplicationController
  
  def index
    if !current_user.nil?
      user = User.find_by(uid: current_user.uid)
      @following_activity = user.return_following_activity
      @mentions = user.return_mentions
    end
  end
  
end
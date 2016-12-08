class UsersController < ApplicationController
  
  def index
    user = User.find_by(uid: current_user.uid)
    @avatar = user.return_avatar
  end
  
end
class UsersController < ApplicationController
  
  def index
    user = User.find_by(uid: current_user.uid)
  end
  
end
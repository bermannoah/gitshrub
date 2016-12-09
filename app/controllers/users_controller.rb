class UsersController < ApplicationController
  
  def index
    @presenter = UsersIndexPresenter.new(current_user)
  end
  
  def repos
    user = User.find_by(uid: current_user.uid)
    @repos = user.return_repos
    @pull_requests = user.return_pull_requests(user[:username])
  end
  
  def new_repo
    user = User.find_by(uid: current_user.uid)
    user.create_repo(params["name"])
    redirect_to repos_path
  end
      
end
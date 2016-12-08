class UsersController < ApplicationController
  
  def index
    user = User.find_by(uid: current_user.uid)
    @avatar = user.return_avatar
    @stars = user.return_star_count
    @followers =  user.return_followers_count
    @following = user.return_following_count
    @repos = user.return_repos
    @organizations = user.return_organization_names
    @commits = user.return_commits(user[:username])
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
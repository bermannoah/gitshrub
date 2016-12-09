class UsersIndexPresenter
    attr_reader :user
    
  def initialize(user)
    @user = user
  end
  
  def avatar
    user = GithubService.new(@user.token).user
    @avatar = user[:avatar_url]
  end
  
  def stars
    @stars = user.return_star_count
  end
  
  def followers
    @followers =  user.return_followers_count
  end
  
  def following
    @following = user.return_following_count
  end
  
  def repos
    @repos = user.return_repos
  end
  
  def organizations
    @organizations = user.return_organization_names
  end
  
  def commits
    @commits = user.return_commits(user[:username])
  end
  
end
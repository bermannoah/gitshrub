class User < ApplicationRecord
  
  def return_avatar
    user = GithubService.new(ENV["GITHUB_USER_TOKEN"]).user
    avatar = user[:avatar_url]
  end
  
  def return_star_count
    stars = GithubService.new(ENV["GITHUB_USER_TOKEN"]).starred
    stars = stars.count
  end
  
  def return_followers_count
    user = GithubService.new(ENV["GITHUB_USER_TOKEN"]).user
    followers = user[:followers]
  end
  
  def return_following_count
    user = GithubService.new(ENV["GITHUB_USER_TOKEN"]).user
    following = user[:following]
  end
  
end
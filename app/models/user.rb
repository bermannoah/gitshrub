class User < ApplicationRecord
  
  def return_avatar
    user = GithubService.new(ENV["GITHUB_USER_TOKEN"]).user
    @avatar = user[:avatar_url]
  end
  
  def return_star_count
    stars = GithubService.new(ENV["GITHUB_USER_TOKEN"]).starred
    @stars = stars.count
  end
  
  
  private
    attr_reader :avatar, :stars
  
end
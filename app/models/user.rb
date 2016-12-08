class User < ApplicationRecord
  
  def return_avatar
    user = GithubService.new(ENV["GITHUB_USER_TOKEN"]).user
    @avatar = user[:avatar_url]
  end
  
  
  private
    attr_reader :avatar
  
end
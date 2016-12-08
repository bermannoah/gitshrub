class User < ApplicationRecord
  
  def return_avatar
    user = GithubService.new(token).user
    avatar = user[:avatar_url]
  end
  
  def return_star_count
    stars = GithubService.new(token).starred
    stars = stars.count
  end
  
  def return_followers_count
    user = GithubService.new(token).user
    followers = user[:followers]
  end
  
  def return_following_count
    user = GithubService.new(token).user
    following = user[:following]
  end
  
  def return_organization_names
    user_organizations = GithubService.new(token).organizations
    user_organizations.map do |organization|
      organization
    end
  end
  
  def return_repos
    repos = GithubService.new(token).repos
    repos.map do |repo|
      repo
    end
  end
  
  def return_pull_requests(username)
    pull_requests = GithubService.new(token).find_pull_requests(username)
    pull_requests.reject { |pr| pr[0].nil? }
  end 
  
  def return_commits(username)
    commits = GithubService.new(token).find_commits(username)
    commits.map do |commit|
      commit
    end
  end
  
  def return_following_activity
    friend_events = GithubService.new(token).find_friend_events
    friend_events.map do |event|
      event
    end
  end
  
  def return_mentions
    mentions = GithubService.new(token).find_mentions
    mentions.map do |mention|
      mention
    end
  end
  
  def create_repo(name)
    NewRepoService.new(token).create_repo(name = name )
  end
end
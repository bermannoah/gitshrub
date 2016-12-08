require 'rails_helper'

describe GithubService do
  context "#repositories" do
    it "returns all repositories for a user", :vcr do
      repos = GithubService.new(ENV["GITHUB_USER_TOKEN"]).repos
      repo = repos.first
    
      expect(repos).to be_an(Array)
      expect(repo).to have_key(:name)
      expect(repo).to have_key(:full_name)
      expect(repo).to have_key(:description)
    end
  end
  
  context "#users" do
    it "returns the avatar for a user", :vcr do
      user = GithubService.new(ENV["GITHUB_USER_TOKEN"]).user

      expect(user).to be_a(Hash)
      expect(user).to have_key(:name)
      expect(user).to have_key(:avatar_url)
      expect(user[:type]).to eq("User")
    end
    
    it "returns the number of followed users for a user", :vcr do
      user = GithubService.new(ENV["GITHUB_USER_TOKEN"]).user

      expect(user).to be_a(Hash)
      expect(user).to have_key(:name)
      expect(user).to have_key(:followers)
      expect(user[:following]).to be_a(Integer)
    end
    
    it "returns the number of followers for a user", :vcr do
      user = GithubService.new(ENV["GITHUB_USER_TOKEN"]).user

      expect(user).to be_a(Hash)
      expect(user).to have_key(:name)
      expect(user).to have_key(:followers)
      expect(user[:followers]).to be_a(Integer)
    end
    
    it "returns the number of a user's starred repos", :vcr do
      starred_repos = GithubService.new(ENV["GITHUB_USER_TOKEN"]).starred
      starred = starred_repos.first

      expect(starred_repos).to be_an(Array)
      expect(starred).to have_key(:owner)
      expect(starred).to have_key(:name)
      expect(starred).to have_key(:private)
    end
    
    it "returns a list of a user's organizations", :vcr do
      user_organizations = GithubService.new(ENV["GITHUB_USER_TOKEN"]).organizations
      organization = user_organizations.first

      expect(user_organizations).to be_an(Array)
      expect(organization).to have_key(:login)
      expect(organization).to have_key(:public_members_url)
      expect(organization).to have_key(:repos_url)
    end
    
    it "returns a list of a user's commits", :vcr do
      commits_for_all_repos = GithubService.new(ENV["GITHUB_USER_TOKEN"]).find_commits("bermannoah")
      first_commit = commits_for_all_repos.first

      expect(commits_for_all_repos).to be_an(Array)
      expect(first_commit[0][:payload][:commits][0]).to have_key(:sha)
      expect(first_commit[0][:payload][:commits][0]).to have_key(:message)
      expect(first_commit[0][:payload][:commits][0]).to have_key(:url)      
    end
    
    it "returns a list of public events from people a user is following", :vcr do
      friend_events = GithubService.new(ENV["GITHUB_USER_TOKEN"]).find_friend_events
      first_event = friend_events.first

      expect(first_event).to be_an(Array)
      expect(first_event[0]).to have_key(:type)
      expect(first_event[0]).to have_key(:payload)
      expect(first_event[0]).to have_key(:public)      
    end
    
    it "returns a list of open pull requests the user has opened", :vcr do
      all_pull_requests = GithubService.new(ENV["GITHUB_USER_TOKEN"]).find_pull_requests("bermannoah")
      first_pull_request = all_pull_requests.second

      expect(first_pull_request).to be_an(Array)
      expect(first_pull_request[0]).to have_key(:title)
      expect(first_pull_request[0]).to have_key(:state)
      expect(first_pull_request[0]).to have_key(:user)
      expect(first_pull_request[0][:state]).to eq("open")            
    end
    
    it "returns a list of open @mentions", :vcr do
      all_mentions = GithubService.new(ENV["GITHUB_USER_TOKEN"]).find_mentions
      
      expect(all_mentions).to be_an(Array)
      expect(all_mentions[0]).to have_key(:unread)
      expect(all_mentions[0]).to have_key(:subject)
      expect(all_mentions[0]).to have_key(:repository)
    end
  end
    
end
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
    
    it "returns the number of a user's organizations", :vcr do
      user_organizations = GithubService.new(ENV["GITHUB_USER_TOKEN"]).organizations
      organization = user_organizations.first

      expect(user_organizations).to be_an(Array)
      expect(organization).to have_key(:login)
      expect(organization).to have_key(:public_members_url)
      expect(organization).to have_key(:repos_url)
    end  
      
  end
  
end
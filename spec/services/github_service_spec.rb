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
  end
  
end
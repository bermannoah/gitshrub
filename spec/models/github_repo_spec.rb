require 'rails_helper'

describe GithubRepo do
  context ".for_user(token)" do
    it "returns repos for a user", :vcr do
        repos = GithubRepo.for_user(ENV["GITHUB_USER_TOKEN"])
        repo = repos.first
        
        expect(repos).to be_an(Array)
        expect(repo).to be_a(GithubRepo)
        expect(repo).to respond_to(:name)
        expect(repo).to respond_to(:full_name)
        expect(repo).to respond_to(:description)
    end
  end
end
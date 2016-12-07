require 'rails_helper'

describe GithubService do
  context "#repositories" do
    it "returns all repositories for a user" do
      VCR.use_cassette("#repos") do

        repos = GithubService.new(ENV["GITHUB_USER_TOKEN"]).repos
        repo = repos.first
      
        expect(repos).to be_an(Array)
        expect(repo).to have_key(:name)
        expect(repo).to have_key(:full_name)
        expect(repo).to have_key(:description)
      end
    end
  end
end
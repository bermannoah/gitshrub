require 'rails_helper'

describe "NewRepoService" do
  context "#repos" do
    it "can post a new repo", :vcr do
      repo_name = Faker::Hacker.noun
      posted_repo_response = NewRepoService.new(ENV["GITHUB_USER_TOKEN"]).create_repo(name = repo_name )

      expect(posted_repo_response).to be_a(Hash)
      expect(posted_repo_response).to have_key(:full_name)
      expect(posted_repo_response).to have_key(:owner)
      expect(posted_repo_response[:owner]).to have_key(:login)
    end
  end
end

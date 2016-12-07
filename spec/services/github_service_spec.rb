require 'rails_helper'

describe GithubService do
  context "#repositories" do
    it "returns all repositories for a user" do
      repos = GithubService.new(token).repos
      
      
    end
  end
end
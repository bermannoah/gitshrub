class GithubRepo
  def self.for_user(token)
    GithubService.new(token).repos
  end
end
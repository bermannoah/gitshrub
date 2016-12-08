class GithubService
  
  def initialize(token)
    @token = token
    @conn = Faraday.new(url: "https://api.github.com/") do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
      faraday.params[:access_token] = token
    end
  end
  
  def user
    response = conn.get("/user")
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def repos
    response = conn.get("/user/repos")
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def starred
    response = conn.get("/user/starred")
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def organizations
    response = conn.get("/user/orgs")
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def find_commits(username)
    find_correct_repos.map do |repo|
      if repo[:owner][:login] == username
        single_response = conn.get("/repos/#{username}/#{repo[:name]}/events")
        JSON.parse(single_response.body, symbolize_names: true)
      end
    end.compact
  end
  
  def find_pull_requests(username)
    find_correct_repos.map do |repo|
      if repo[:owner][:login] == username
        single_response = conn.get("/repos/#{username}/#{repo[:name]}/pulls")
        JSON.parse(single_response.body, symbolize_names: true)
      end
    end.compact
  end
      
  def find_friend_events
    response = conn.get("/user/following")
    all_friends = JSON.parse(response.body, symbolize_names: true)
    all_friends.map do |friend|
      single_response = conn.get("users/#{friend[:login]}/events")
      JSON.parse(single_response.body, symbolize_names: true)
    end
  end
  
  def find_mentions
    response = conn.get("/notifications")
    JSON.parse(response.body, symbolize_names: true)
  end
        
  private
    
    attr_reader :token, :conn, :all_repos
    
    def find_correct_repos
      response = conn.get("/user/repos")
      all_repos = JSON.parse(response.body, symbolize_names: true)
    end
  
end
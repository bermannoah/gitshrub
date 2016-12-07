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
    response = conn.get("/user/repos")
    all_repos = JSON.parse(response.body, symbolize_names: true)
    commits = all_repos.map do |repo|
      if repo[:owner][:login] == username
        single_response = conn.get("/repos/#{username}/#{repo[:name]}/events")
        JSON.parse(single_response.body, symbolize_names: true)
      end
    end.compact
  end
    
  def create_repo(name = "Hello-World",
                  description = "This is a test repo.",
                  homepage = "https://github.com",
                  private = false,
                  has_issues = true,
                  has_wiki = true,
                  has_downloads = true)
                  
    response = conn.post do |contents|
      contents.url("/user/repos")
      contents.headers['Content-Type'] = 'application/json'
      contents.body = {
          "name": "#{name}",
          "description": "#{description}",
          "homepage": "#{homepage}",
          "private": "#{private}",
          "has_issues": "#{has_issues}",
          "has_wiki": "#{has_wiki}",
          "has_downloads": "#{has_downloads}"
        }.to_json
    end
    
    JSON.parse(response.body, symbolize_names: true)
  end
    
  private
    
    attr_reader :token, :conn
  
end
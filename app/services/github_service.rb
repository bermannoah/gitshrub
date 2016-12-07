class GithubService
  
  def initialize(token)
    @token = token
    @conn = Faraday.new(url: "https://api.github.com/") do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
      faraday.params[:access_token] = token
    end
  end
  
  def repos
    response = conn.get("/user/repos")
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def user
    response = conn.get("/user")
    JSON.parse(response.body, symbolize_names: true)
  end
  
  def starred
    response = conn.get("/user/starred")
    JSON.parse(response.body, symbolize_names: true)
  end

  
  private
    
    attr_reader :token, :conn
  
end
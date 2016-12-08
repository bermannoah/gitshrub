class NewRepoService
  
  def initialize(token)
    @token = token
    @conn = Faraday.new(url: "https://api.github.com/") do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
      faraday.params[:access_token] = token
    end
  end

  def create_repo(name = "Hello-World",
                  description = "This is a test repo.",
                  homepage = "https://github.com",
                  has_issues = true
                  )
                  
    response = conn.post do |contents|
      contents.url("/user/repos")
      contents.headers['Content-Type'] = 'application/json'
      contents.body = {
          name: "#{name}",
          description: "#{description}",
          homepage: "#{homepage}",
          has_issues: "#{has_issues}",
        }.to_json
    end
    
    JSON.parse(response.body, symbolize_names: true)
  end
  
  private
    attr_reader :conn

end
class SessionsController < ApplicationController
  
	def create
    @response = Faraday.post("https://github.com/login/oauth/access_token?client_id=#{ENV['GITHUB_CLIENT_ID']}&client_secret=#{ENV['GITHUB_CLIENT_SECRET']}&code=#{params["code"]}")

	  token = @response.body.split(/\W+/)[1]

	  oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")

	  auth = JSON.parse(oauth_response.body)

	  user                = User.find_or_create_by(uid: auth["uid"])
	  user.username       = auth["login"]
	  user.uid			      = auth["id"]
	  user.token	        = token
	  user.save

	  session[:user_id] = user.id

	  redirect_to root_path
	end
  
  def destroy
    session.clear
    redirect_to root_path, flash: { success: "Signed out successfully." }
  end
end

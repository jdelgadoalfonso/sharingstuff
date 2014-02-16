class SessionsController < ApplicationController
  def new
    @menu_actual = 0
  end

  def create
    @menu_actual = 0
    begin
        File.delete(Rails.root.join('app', 'assets', 'images', session[:avatar])) unless session[:avatar] == nil
    rescue
    end
    if params[:subirFoto] == false
      auth_hash = request.env['omniauth.auth']
      if session[:user_id]
        userExist(auth_hash)
      else
        if params[:provider] != nil && params[:provider] == "sharingstuff"
          signinThroughSharingStuff
        else        
          signinThroughSocialNetwork(auth_hash)
        end
    
        # Create the session
        session[:user_id] = auth.user.id
    
        render :text => "Welcome #{auth.user.name}!"
      end
    else
      subirImagen
    end
  end

  private
  def userExist(auth_hash)
    # Means our user is signed in. Add the authorization to the user
    #@user = User.find_by_id(session[:user_id]).add_provider(auth_hash)
    (@user = User.find(session[:user_id])).add_provider(auth_hash)
      
    InvitationMailer.welcome_email(@user).deliver
 
    render :text => "You can now login using #{auth_hash["provider"].capitalize} too!"
  end

  private
  def signinThroughSharingStuff
    if params[:password] != nil && params[:password] == params[:password_confirmation]
      extension = /\.[a-zA-Z]{3,4}$/.match(params[:avatar].original_filename) unless params[:avatar] == nil
      ext = extension[0] unless extension == nil
      auth_hash = recogerParametros ext
      auth = Authorization.find_or_create_noauth(auth_hash)
    else
      # TODO
    end
  end
  
  private
  def recogerParametros(ext)
    auth_hash = Hash.new
    auth_hash = {
      "provider" => params[:provider],
      "uid" => 0,
      "info" => {
        "name" => params[:Username],
          "email" => params[:email_of_user],
          "password" => params[:password],
          "comment" => params[:comment],
          "avatar_format" => ext
      }
    }
    auth_hash["info"]["avatar"] = params[:avatar] unless ext == nil;
    return auth_hash
  end
  
  private
  def signinThroughSocialNetwork(auth_hash)
    # Log him in or sign him up
    auth = Authorization.find_or_create_auth(auth_hash)

    @user = auth.user

    oauth_access_token = auth_hash['credentials']["token"]
    if auth_hash["provider"].capitalize == "Facebook"
      graph = Koala::Facebook::API.new(oauth_access_token)
      graph.put_connections("me", "feed", :message => "I am writing on my wall!")
    elsif auth_hash["provider"].capitalize == "Google_oauth2"
      contacts(oauth_access_token)
    elsif auth_hash["provider"].capitalize == "Twitter"
    # TODO: Write a message to his/her followers
    end
  end
  
  private
  def subirImagen
    avatar = params[:avatar]
    if avatar != nil
      extension = /\.[a-zA-Z]{3,4}$/.match(avatar.original_filename)
      type = /\Aimage/.match(avatar.content_type)
      if type != nil
        session[:avatar] = session[:session_id] + extension[0]
        f = File.new(Rails.root.join('app', 'assets', 'images', session[:avatar]), "wb")
        f.write(avatar.read)
        f.close
      end
    else
      session[:avatar] = nil
    end
    session[:formSign] = recogerParametros nil
    redirect_to :action => "signup", :controller => "login"
  end
  
  def failure
    render :text => "Sorry, but you didn't allow access to our app!"
  end
  
  def destroy
    session[:user_id] = nil
    render :text => "You've logged out!"
  end

  private
  def contacts(access_keys)
    uri = URI.parse("https://www.google.com/m8/feeds/contacts/default/full?oauth_token=#{access_keys}&max-results=500000&alt=json")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    contacts = ActiveSupport::JSON.decode(response.body)
    contacts['feed']['entry'].each_with_index do |contact,index|

      name = contact['title']['$t']
      contact['gd$email'].to_a.each do |email|
        puts email['address']
        # TODO: send an email
        # UserMailer.welcome_email(@user).deliver
 
        # format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        # format.json { render :json => @user, :status => :created, :location => @user }
      end
    end
  end
  
end

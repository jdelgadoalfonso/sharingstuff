Rails.application.config.middleware.use OmniAuth::Builder do
  
  OmniAuth.config.on_failure = Proc.new do |env|
    SessionsController.action(:failure).call(env)
    #this will invoke the omniauth_failure action in UsersController.
  end
  
  provider :google_oauth2, "553329723007.apps.googleusercontent.com", "Sh7e7CmKAzquWj7DVI8qMIBF",
           :scope => 'userinfo.email,userinfo.profile,https://www.google.com/m8/feeds/',
           :approval_prompt => "auto",
           :access_type => 'online'
  provider :twitter, "Wr0SmySA8OdFrrwd3Irlg", "wxk3V8ARLGH0PhmTJ8zg1icwfmpYCXBiGGFWwlHF8o"
  provider :facebook, "497350010322773", "c744d631b987195fff1ef7f8de7dec43",
           :scope => 'email,offline_access,publish_stream',
           :display => 'popup'
end
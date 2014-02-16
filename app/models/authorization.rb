class Authorization < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id, :user, :password
  belongs_to :user
  validates :provider, :uid, :presence => true
  
  def self.find_or_create_auth(auth_hash)
    unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
      user = User.create :name => auth_hash["info"]["name"],
        :email => auth_hash["info"]["email"],
        :comment => auth_hash["info"]["comment"],
        :avatar => auth_hash["info"]["avatar"].read
      auth = Authorization.create :user => user,
        :provider => auth_hash["provider"],
        :uid => auth_hash["uid"]
    end

    auth
  end
  
  def self.find_or_create_noauth(auth_hash)
    unless user = User.find_by_email(auth_hash["info"]["email"])
      Authorization.transaction do
        user = User.create :name => auth_hash["info"]["name"],
          :email => auth_hash["info"]["email"],
          :comment => auth_hash["info"]["comment"],
          :avatar => auth_hash["info"]["avatar"].read,
          :avatar_format => auth_hash["avatar_format"]
        auth = Authorization.create :user => user,
          :provider => auth_hash["provider"],
          :uid => auth_hash["uid"],
          :password => (Digest::SHA2.new << auth_hash["info"]["password"]).to_s
      end
    end
    
    auth = (auth == nil) ? find_by_provider_and_user_id(auth_hash["provider"], user.id) : auth

    auth
  end
  
end

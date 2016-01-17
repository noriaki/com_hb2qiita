class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :uid, type: String
  field :provider, type: String

  field :nickname, type: String
  field :image_url, type: String

  field :access_token, type: String


  class << self

    def create_with_omniauth(auth)
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        if auth['info']
          user.nickname = auth['info']['nickname']
          user.image_url = auth['info']['image']
        end
        if auth['credentials']
          user.access_token = auth['credentials']['token']
        end
      end
    end

  end
end

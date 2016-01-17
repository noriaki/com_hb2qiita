class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :uid, type: String
  field :provider, type: String

  field :nickname, type: String
  field :image_url, type: String

  field :access_token, type: String

  field :hatebu_name, type: String
  field :hatebu_key, type: String

  index({ uid: 1 }, { background: true, unique: true })
  index({ uid: 1, provider: 1 }, { background: true, unique: true })
  index({ hatebu_key: 1 }, { background: true, unique: true })

  validates_presence_of :uid
  validates_presence_of :provider
  validates_presence_of :nickname
  validates_presence_of :access_token
  validates_presence_of :hatebu_key
  validates_uniqueness_of :hatebu_key

  def generate_hatebu_key
    Digest::SHA256.hexdigest "#{self.uid}-#{rand}-#{Time.current}"
  end

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
        user.hatebu_key = user.generate_hatebu_key
      end
    end

  end

end

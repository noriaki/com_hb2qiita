Rails.application.config.middleware.use OmniAuth::Builder do
  provider :qiita, ENV["QIITA_CLIENT_ID"], ENV["QIITA_CLIENT_SECRET"], scope: [
    'read_qiita', 'write_qiita'
  ].join(' ')
end

OmniAuth.config.logger = Rails.logger

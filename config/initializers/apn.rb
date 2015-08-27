if Rails.env.production?
  # Production only
  ::APN = Houston::Client.production
else
  # Staging and development environments
  ::APN = Houston::Client.development
end

APN.certificate = File.read(Rails.root.join('config', 'pushcert.pem'))

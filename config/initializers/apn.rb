::APN = Houston::Client.development
APN.certificate = File.read(Rails.root.join('config', 'pushcert.pem'))

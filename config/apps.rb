##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#
Padrino.configure_apps do
  # enable :sessions
  set :session_secret, 'heeeeeeeeeeeeeeeeey_yaaaaaaaaaaaaaa'
end

# Mounts the core application for this project
Padrino.mount("Rp").to('/')

# The line added to make Padrino add the Grape API as a subapp
Padrino.mount("API", :app_class => "APIS::API").to('/api')

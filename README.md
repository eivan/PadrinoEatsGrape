PadrinoEatsGrape
================

Sample project skeleton for the great API framework Grape, having built into Padrino framework nicely.

Padrino took the Grape.
Please fork this repo and feel free to add your extensions to it!

## Structure

Example:

    appname.commonity.com/api/{vendor}/v1/...

Your Padrino app could include an 'api' directori for the Grape API in its root.

    \api
    \api\app.rb                           # Methods important for Padrino integration
    \api\helpers                          # Directory containing helper methods
    \api\vendors                          # Directory containing series of vendors
    \api\vendors\{a_vendor}               # A vendor's api's directorz
    \api\vendors\{a_vendor}\version_1.rb  # API versions

## config\apps.rb

Add this line:

    Padrino.mount("API", :app_class => "Genie3::API").to('/api')

## Gemfile

    gem "grape",         git: "http://github.com/intridea/grape.git", :branch => "frontier"
    gem 'grape-swagger', git: "https://github.com/tim-vandecasteele/grape-swagger.git"



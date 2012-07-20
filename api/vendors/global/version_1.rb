Grape::API.logger Padrino.logger

module APIS
  module Vendors
    module Global
    
      class API_v1 < Grape::API
        version 'v1', :using => :header, :vendor => 'global', :format => :json
        
        rescue_from :all do |e|
          logger.error "API << #{env['REQUEST_METHOD']} #{env['PATH_INFO']}; errors: #{e.message}"
          rack_response({ error: e.class.name, message: e.message })
        end
        
        resource :users do
          crud MyApp::User, :user
        end
        
        desc "Documentates api"
        get :doc do
          {
            versions: APIS::Vendors::Global::API_v1.versions,
            routes: APIS::Vendors::Global::API_v1.routes.map do |route|
              route_path = route.route_path.gsub('(.:format)', '').gsub(':version', route.route_version)
              {
                route: "#{route.route_method} #{route_path}",
                desc: "#{route.route_description}",
                params: route.route_params
              }
            end
          }
        end
        
        get :any do
          logger.error "API << #{env['REQUEST_METHOD']} #{env['PATH_INFO']}; errors: Not Found"
          error!({message: "#{env['REQUEST_METHOD']} #{env['PATH_INFO']}", errors: "Not Found"},404)
        end
        
      end
    end
  end
end

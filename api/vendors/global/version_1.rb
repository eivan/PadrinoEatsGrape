Grape::API.logger Padrino.logger

module APIS
  module Vendors
    module Global
    
      class API_v1 < Grape::API
        prefix 'global'
        default_format :json
        error_format :json
        version 'v1', :using => :header, :vendor => 'global', :format => :json
        
        before do
          header['Access-Control-Allow-Origin'] = '*'
          header['Access-Control-Request-Method'] = '*'
        end
        
        rescue_from :all do |error|
          logger.error "API << #{env['REQUEST_METHOD']} #{env['PATH_INFO']} -- #{error.class.name} -- #{error.message}"
          logger.info "API << Last error's backtrace:\n#{error.backtrace.join("\n")}"
          
          json = { error: error.class.name, message: error.message }.to_json
          code = 500
          
          headers = 
          {
            'Content-Type' => 'application/json',
            'Access-Control-Allow-Origin' => '*',
            'Access-Control-Request-Method' => '*'
          }
          
          rack_response(json, code, headers)
        end
        
        resource :users do
          crud MyApp::User, :user
        end

        get :any do
          logger.error "API << #{env['REQUEST_METHOD']} #{env['PATH_INFO']}; errors: Not Found"
          error!({message: "#{env['REQUEST_METHOD']} #{env['PATH_INFO']}", errors: "Not Found"},404)
        end
        
      end
    end
  end
end

Grape::API.logger Padrino.logger

module APIS

  class API < Grape::API
  
    class << self
      def root
        @_root ||= File.expand_path('..', __FILE__)
      end
    
      def dependencies
        @_dependencies ||= [
          "helpers/*.rb", "helpers.rb", "vendors/**/version_*.rb", "vendors/**/version_*/*.rb"
        ].map { |file| Dir[File.join(self.root, file)] }.flatten
      end
      
      def load_paths
        @_load_paths ||= %w(models lib mailers controllers helpers).map { |path| File.join(self.root, path) }
      end
      
      def require_dependencies
        Padrino.set_load_paths(*load_paths)
        Padrino.require_dependencies(dependencies, :force => true)
      end
      
      def setup_application!
        return if @_configured
        self.require_dependencies
        @_configured = true
        @_configured
      end
      
      def app_file; ""; end
      def public_folder; ""; end
    end
    
    setup_application!
    
    after { logger.info "API << #{env['REQUEST_METHOD']} #{env['PATH_INFO']}; errors: #{env["rack.errors"].inspect}" }

    ## TODO find a better way than this    
    mount ::APIS::Vendors::Global::API_v1

    add_swagger_documentation mount_path: "/swagger", base_path: "http://localhost:3000/api", api_version: "v1"
    
    #http://petstore.swagger.wordnik.com/
    # <== http://localhost:3000/api/swagger/global

  end

end

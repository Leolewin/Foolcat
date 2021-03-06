require 'bundler'

Bundler.require

require 'yaml'

#Set current file folder path to the $LOAD_PATH
#if not do this, modules followed in the project need to be required by full path instead of relative path!
$: << File.expand_path(File.dirname(__FILE__))

#load common utils and global config settings
require_all 'util'

#load all base module files under app folder, load sequence is important modelmodule > routebase
require 'app/models/modelmodule'
require 'app/routes/routebase'
require 'app/routes/api/apimodule'
require 'app/routes/page/pagemodule'
# require 'test'


module Foolcat
    
    class App < Sinatra::Application
        
        include Reflection

        #common config for the project
        configure do 
            set :root, App.root #used to construct the default :public_folder
            # disable :method_override #disable the POST _method hack
            set :public_folder, App.root + '/public'
            set :views, App.root + '/app/views'

        end
        
        use Rack::Deflater
        use Rack::Session::Pool, :expire_after => 7200


        #declare/register Page Module for Rack middleware, check middleware.to_s
        #which you can see by: p  middleware.to_s
        #example: use Foolcat::Page::LoginPage
        
        page_route_dir = App.root + '/app/routes/page'
        
        Resolver.get_all_klass_name(page_route_dir) { |klassname|
            use Object.const_get('Foolcat::Page::' + klassname)
        }
        
        #declare/register API Module for Rack middleware, check middleware.to_s
        #example: use Foolcat::RestAPI::WPTAPI
        #howerver, I haven't thought a api to use so far
        api_route_dir = App.root + '/app/routes/api'
        
        Resolver.get_all_klass_name(api_route_dir) { |klassname|
            use Object.const_get('Foolcat::RestAPI::' + klassname)
        }


        #custom the 404 page here, layout is not used
        error Sinatra::NotFound do
            content_type 'text/plain'
            [404, 'Not Found']
            haml :not_found, :layout => false
        end
       
    end
    
end

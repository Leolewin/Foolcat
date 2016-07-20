module Foolcat
    module Page
        
        class HomePage < BasePage
            
            get '/home' do
                # Pass session data to haml file by @param
                #in the page, you can use it in script
                @login_name = session[:loginuser]
                haml :home
            end
            
        end
    end
end
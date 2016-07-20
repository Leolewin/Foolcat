module Foolcat
    module DBModel
        
        class User < Sequel::Model(:user)
    
            def User.getUserByName(uname)
                User[:username => uname]
            end

            def User.regUserByName(uname)
                if(!User[:username => uname])
                    User[:username] = uname
                    return 'succeed'
                else
                  return 'failed'
                end
            end
    
        end

    end
end
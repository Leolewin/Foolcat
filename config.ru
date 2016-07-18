require './app'

run Foolcat::App

#or you can run against thin web server to set its port
#Rack::Handler::Thin.run Foolcat::App, :Port => 9001 , Host => "0.0.0.0"

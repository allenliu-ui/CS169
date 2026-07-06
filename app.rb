require 'sinatra'

class MyApp < Sinatra::Base
  # Disable the security middleware blocking external preview headers
  set :host_authorization, { permitted_hosts: [] }

  get '/' do
    "<!DOCTYPE html><html><head></head><body><h1>Goodbye Everyone</h1></body></html>"
  end
end

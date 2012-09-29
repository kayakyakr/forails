module Forails
  class Engine < ::Rails::Engine
    isolate_namespace Forails
    
    config.to_prepare do |config|
      ::User.send :include, Forails::MoreUser
    end
  end
end

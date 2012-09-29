module Forails
  class ApplicationController < ::ApplicationController
    check_authorization
    
    rescue_from CanCan::AccessDenied do |exception|
      redirect_to root_url, :alert => exception.message
    end
  end
end

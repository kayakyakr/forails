require_dependency "forails/application_controller"

module Forails
  class AdminController < ApplicationController
    respond_to :html
    
    def index
      authorize! :manage, :all
    end
  end 
end
require_dependency "forails/application_controller"

module Forails
  class Admin::ForumsController < ApplicationController
    respond_to :html
    
    def new
      @forum = Forum.new
      authorize! :create, @forum
      respond_with @forum
    end
  
    def edit
      @forum = Forum.find(params[:id])
      authorize! :update, @forum
      respond_with @forum
    end
  
    def create
      @forum = Forum.new(params[:forum])
      authorize! :create, @forum
      
      @forum.save
      respond_with @forum, notice: 'Forum was successfully created.'
    end
  
    def update
      @forum = Forum.find(params[:id])
  
      authorize! :update, @forum
      @forum.update_attributes(params[:forum])
      respond_with @forum, notice: 'Forum was successfully updated.'
    end
  
    def destroy
      @forum = Forum.find(params[:id])
      
      authorize! :destroy, @forum
      @forum.destroy
  
      respond_with @forum
    end
  end
end

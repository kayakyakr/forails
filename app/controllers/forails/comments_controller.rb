require_dependency "forails/application_controller"

module Forails
  class CommentsController < ApplicationController
    respond_to :html
    
    def new
      @comment = Comment.new(topic_id: params[:topic_id])
      authorize! :create, @comment
      respond_with @comment
    end
  
    def edit
      @comment = Comment.find(params[:id])
      authorize! :update, @comment
      respond_with @comment
    end
  
    def create
      @comment = Comment.new(params[:comment])
      @comment.user = current_user
      
      authorize! :create, @comment
      @comment.save
      respond_with @comment.topic
    end
  
    def update
      @comment = Comment.find(params[:id])
  
      authorize! :update, @comment
      @comment.update_attributes(params[:comment])
      respond_with @comment.topic
    end
  
    def destroy
      @comment = Comment.find(params[:id])
      authorize! :create, @comment
      @comment.destroy
      respond_with @comment.topic  
    end
  end
end

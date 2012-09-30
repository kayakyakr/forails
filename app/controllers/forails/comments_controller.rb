require_dependency "forails/application_controller"

module Forails
  class CommentsController < ApplicationController
    respond_to :html
    
    def new
      @comment = Comment.new(topic_id: params[:topic_id])
      if params[:comment_id]
        quoted = Comment.find(params[:comment_id])
        @comment.content = quoted.quote if quoted && can?(:read, quoted)
      end
      authorize! :create, @comment
      respond_with @comment
    end
  
    def edit
      @comment = Comment.find(params[:id])
      authorize! :update, @comment
      
      if @comment.topic.comments.first == @comment
        redirect_to edit_topic_path(@comment.topic)
        return;
      end
      
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

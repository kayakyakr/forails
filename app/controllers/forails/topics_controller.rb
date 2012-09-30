require_dependency "forails/application_controller"

module Forails
  class TopicsController < ApplicationController
    respond_to :html
    
    def show
      @topic = Topic.find(params[:id])
      authorize! :read, @topic
      respond_with @topic
    end
  
    def new
      @forum = Forum.find(params[:forum_id])
      if @forum.is_category?
        authorize! :read, @forum
        redirect_to(@forum, notice: "Cannot create topics in this forum")
        return
      end
      
      @topic = Topic.new(forum_id: params[:forum_id])
      @comment = @topic.comments.build(user: current_user)
      
      authorize! :create, @topic
      respond_with @topic
    end
  
    def edit
      @topic = Topic.find(params[:id])
      @comment = @topic.comments.first
      authorize! :update, @comment
      authorize! :update, @topic
      respond_with @topic
    end
  
    def create
      @forum = Forum.find(params[:topic][:forum_id])
      if @forum.is_category?
        authorize! :read, @forum
        redirect_to(@forum, notice: "Cannot create topics in this forum")
        return
      end
      
      @topic = Topic.new(params[:topic])
      @topic.user = current_user
      
      @comment = @topic.comments.build(params[:comment])
      @comment.user = current_user
  
      authorize! :create, @topic
      authorize! :create, @comment
      
      @topic.save
      respond_with @topic
    end
  
    def update
      @topic = Topic.find(params[:id])
      @comment = @topic.comments.first
      
      authorize! :update, @topic
      authorize! :update, @comment
      @topic.update_attributes(params[:topic])
      @comment.update_attributes(params[:comment])
      respond_with @topic
    end
  
    def destroy
      @topic = Topic.find(params[:id])
      authorize! :destroy, @topic
      if @topic.destroy
        respond_with @topic.forum
      else
        respond_with @topic
      end
    end
  end
end

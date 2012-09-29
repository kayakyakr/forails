require_dependency "forails/application_controller"

module Forails
  class ForumsController < ApplicationController
    respond_to :html
    
    def index
      @forums = Forum.index.order("sequence IS NULL, sequence ASC")
      @forums.reject!{|f| ['none', nil].include?(f.permission(current_user)) }
      authorize! :read, @forums
      respond_with(@forums)
    end
  
    def show
      @forum = Forum.find(params[:id])
      @subforums = @forum.children.reject{|f| ['none', nil].include?(f.permission(current_user)) }
      authorize! :read, @forum
      authorize! :read, @subforums
      respond_with(@forums, @subforums)
    end
  
  end
end

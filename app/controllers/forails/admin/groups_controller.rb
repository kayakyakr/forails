require_dependency "forails/application_controller"

module Forails
  class Admin::GroupsController < ApplicationController
    respond_to :html
    
    def index
      authorize! :manage, :all
      respond_with(@groups = Group.all)
    end
  
    def show
      authorize! :manage, :all
      respond_with(@group = Group.find(params[:id]))
    end
  
    def new
      authorize! :manage, :all
      @group = Group.new
  
      # Seed forums_groups
      @group.forums_groups.build forum: nil, permission: 'inherited'
      Forum.where("").each do |forum|
        @group.forums_groups.build forum: forum, permission: 'inherited'
      end
      
      respond_with(@group)
    end
  
    def edit
      authorize! :manage, :all
      @group = Group.find(params[:id])
      
      @group.forums_groups.build forum: nil, permission: 'inherited' unless @group.forums_groups.where(forum_id: nil).exists?
      Forum.where("id NOT IN (?)", @group.forums | [0]).each do |forum|
        @group.forums_groups.build forum: forum, permission: 'inherited'
      end
      
      respond_with(@group)
    end
  
    def create
      authorize! :manage, :all
      @group = Group.new(params[:group])
  
      @group.forums_groups.each do |fg|
        fg.mark_for_destruction if fg.permission == 'inherited' || fg.permission.blank?
      end
      
      @group.save
      respond_with(:admin, @group)
    end
  
    def update
      authorize! :manage, :all
      @group = Group.find(params[:id])
      
      params[:group][:forums_groups_attributes].each do |k, fga|
        fg = @group.forums_groups.select{|s| s.id == fga[:id].to_i}.first
        fg.attributes = fga if fg
      end      
      @group.forums_groups.each do |fg|
        fg.mark_for_destruction if fg.permission == 'inherited' || fg.permission.blank?
      end
      
      @group.update_attributes(params[:group])
      respond_with(:admin, @group)
    end
  
    def destroy
      authorize! :manage, :all
      @group = Group.find(params[:id])
      @group.destroy
      respond_with(:admin, @group)
    end
  end
end

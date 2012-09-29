require_dependency "forails/application_controller"

module Forails
  class Admin::UsersController < ApplicationController
    respond_to :html
    
    def search
      authorize! :manage, :all
      respond_with(@users = User.where("name = :name OR email = :name", name: (params[:search] || {})[:name]))
    end
  
    def edit
      authorize! :manage, :all
      respond_with(@user = User.find(params[:id]), @other_groups = (Group.all - @user.groups) )
    end
  
    def update
      authorize! :manage, :all
      @user = User.find(params[:id])
      @group = Group.find(params[:group_id])
      
      @user.groups.delete(@group) if params[:act] == 'remove'
      @user.groups << @group if params[:act] == 'add'
      
      redirect_to admin_users_path(@user.id)
    end
  end
end

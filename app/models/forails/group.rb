module Forails
  class Group < ActiveRecord::Base
    has_and_belongs_to_many :users, :join_table => :forails_groups_users
    
    has_many :forums_groups, autosave: true, dependent: :destroy
    has_many :forums, through: :forums_groups
    
    accepts_nested_attributes_for :forums_groups
    
  end
end

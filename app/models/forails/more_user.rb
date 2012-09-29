module Forails
  module MoreUser
    def self.included(base)
      base.has_and_belongs_to_many :groups, :join_table => "forails_groups_users", :class_name => "Forails::Group"
      
      base.has_many :forums_groups, :class_name => "Forails::ForumsGroup", :through => :groups
    end
  end
end
module Forails
  class Forum < ActiveRecord::Base
    has_many :topics
    has_many :forums_groups
    
    require_dependency 'acts_as_tree'
    include ::ActsAsTree
    acts_as_tree order: 'sequence', foreign_key: :parent_forum_id
    
    def self.index
      where(parent_forum_id: nil)
    end
    
    def descendants
      self.children.map{|child| [child] + child.descendants}.flatten.compact
    end
    
    def permission(user)
      catch(:read) do
        f = self
        fg = Forails::ForumsGroup.joins(:group => :users).where(:forum_id => f, "users.id" => user.id).first
        throw :read, fg.permission unless fg.nil?
        begin
          f = f.parent
          fg = Forails::ForumsGroup.joins(:group => :users).where(:forum_id => f, "users.id" => user.id).first
          throw :read, fg.permission unless fg.nil?
        end while f
      end
    end
  end
end

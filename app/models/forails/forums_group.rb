module Forails
  class ForumsGroup < ActiveRecord::Base
    belongs_to :group
    belongs_to :forum
    
    validate :group_id, :uniqueness => {:scope => :forum_id}
    validate :forum_id, :uniqueness => {:scope => :group_id}
  end
end

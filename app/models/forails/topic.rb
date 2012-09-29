module Forails
  class Topic < ActiveRecord::Base
    belongs_to :forum
    belongs_to :user
    has_many :comments, :autosave => true, :inverse_of => :topic
    
    accepts_nested_attributes_for :comments
    
    validates :user, presence: true
    validates :forum, presence: true
  end
end

module Forails
  class Comment < ActiveRecord::Base
    belongs_to :topic, inverse_of: :comments
    belongs_to :user
    
    validates :topic, presence: true
    validates :user, presence: true
  end
end

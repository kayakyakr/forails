module Forails
  class Comment < ActiveRecord::Base
    belongs_to :topic, inverse_of: :comments
    belongs_to :user
    
    validates :topic, presence: true
    validates :user, presence: true
    
    def quote
      %{#{user.name} said, "#{content}"}
    end
    
    def content
      ActionController::Base.helpers.sanitize(self[:content], :tags => %w(br p i b img s em strong a)).html_safe
    end
  end
end

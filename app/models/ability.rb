class Ability
  include CanCan::Ability

  def initialize(user)
    
    # Defines actions that non-users can perform
    unless user
      # Defines viewing forums
      # Defines viewing topics
      # Defines viewing comments
      return
    end
    
    # Defines all of the actions that a global admin can perform
    if user.forums_groups.where(:forum_id => nil, :permission => "can_admin")
      can :manage, :all
      return
    end
    
    cannot :manage, :all # deny permissions unless allowed down the road
    
    # Defines actions on forums
    can :read, Forails::Forum do |forum|
      case forum.permission(user) when 'can_admin', 'can_moderate', 'can_view' then true else false end
    end
    can :update, Forails::Forum do |forum|
      case forum.permission(user) when 'can_admin' then true else false end
    end
    
    # Defines actions on topics
    can [:read, :create], Forails::Topic do |topic|
      case topic.forum.permission(user) when 'can_admin', 'can_moderate', 'can_view' then true else false end
    end
    can :update, Forails::Topic do |topic|
      topic.user == user || case topic.forum.permission(user) when 'can_admin', 'can_moderate' then true else false end
    end
    can :destroy, Forails::Topic do |topic|
      case topic.forum.permission(user) when 'can_admin', 'can_moderate' then true else false end
    end
    
    # Defines actions on comments
    can [:read, :create], Forails::Comment do |comment|
      case comment.topic.forum.permission(user) when 'can_admin', 'can_moderate', 'can_view' then true else false end
    end
    can :update, Forails::Comment do |comment|
      comment.user == user || case comment.topic.forum.permission(user) when 'can_admin', 'can_moderate' then true else false end
    end
    can :destroy, Forails::Comment do |comment|
      case comment.topic.forum.permission(user) when 'can_admin', 'can_moderate' then true else false end
    end
    
  end
end

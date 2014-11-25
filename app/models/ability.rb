class Ability
  include CanCan::Ability

  def initialize(user)

  	if user.nil?
      can :session, :login
      return
    end
    unless user.is_approve
    	can :session, :login
        return
    end

    can :update,User, :id => user.id

    if user.is_approve
    	can :index,Leave#,:user_id => user.id,:reporter1_id =>user.id,:reporter2_id => user.id
    	can :create ,Leave
    	can :destroy,Leave
    	
    	can :receive,Leave
    	can :auddit,Leave
    	can :auddit_from_mail,Leave
    	can :show,User

        

    end
    if user.is_leader
    	can :read,Leave#,:user_id => user.id,:reporter1_id =>user.id,:reporter2_id => user.id
    	can :create ,Leave
    	can :destroy,Leave
    	can :update,Leave
    	can :receive,Leave
    	can :auddit,Leave
        can :auddit_from_mail,Leave
        can :show,User
        can :list,Leave
    	can :export_data,Leave
        #can :index,DashBoard
    end
    if user.role_id==1
    	#can :update,Leave
    	can :read,Leave
    	can :list,Leave
    	can :export_data,Leave
    end
    if user.is_admin?
    	can :manage, :all
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end

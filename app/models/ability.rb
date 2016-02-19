class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      user.admin? ? admin_abilities : user_abilities(user)
    else
      guest_abilities
    end
  end

  private

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities(user)
    guest_abilities
    can :manage, [Question, Answer, Comment], user: user
    can :destroy, Attachment, attachable: {user: user}
    can :select_best, Answer, question: {user_id: user.id}
    cannot :select_best, Answer, user_id: user.id
    can :update, User, id: user.id

    can :create, Subscription
    can :destroy, Subscription do |subscription|
      subscription.question.is_subscribed_with?(user)
    end


    alias_action :positive, :negative, to: :say_opinion_for
    can :say_opinion_for, [Question, Answer]
    cannot :say_opinion_for, [Question, Answer], user: user
    can :me, User, id: user.id


  end


end


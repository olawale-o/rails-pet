class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :read, :Dog
    can :manage, :Dog, user: user
  end
end

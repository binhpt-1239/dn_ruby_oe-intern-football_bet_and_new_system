# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize user
    method_if_not_login
    return if user.blank?

    method_if_user_login user
    return unless user.admin?

    can :manage, :all
  end

  private

  def method_if_not_login
    can :home, SoccerMatch
    can :read, SoccerMatch
    can :read, GoalResult
    can :read, TeamTournament
    can :read, Team
    can :read, Tournament
    can :read, Player
    can :read, PlayerInfo
  end

  def method_if_user_login user
    can :read, Bet
    can :manage, UserBet, user_id: user.id
    can :manage, User, id: user.id
    can :read, Currency, user_id: user.id
    can :create, Currency, user_id: user.id
    can :manage, Comment, user_id: user.id
    can :manage, News, user_id: user.id
  end
end

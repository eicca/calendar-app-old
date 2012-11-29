class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Student.new # guest user

    if user.kind_of? Teacher
      can :manage, Teacher, id: user.id
    elsif user.kind_of? Student
      can :manage, Student, id: user.id
    end

    can :read, :all

  end
end

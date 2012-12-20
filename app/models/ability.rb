class Ability
  include CanCan::Ability

  # TODO lesson managing
  # TODO lesson status changing

  def initialize(user)
    user ||= Student.new # guest user

    if user.kind_of? Teacher
      can :manage, Teacher, id: user.id
      can :manage, Schedule, teacher_id: user.id
      can :manage, Lesson, teacher_id: user.id
    elsif user.kind_of? Student
      can :manage, Student, id: user.id
      can :manage, Lesson, student_id: user.id
    end

    can :read, :all

  end
end

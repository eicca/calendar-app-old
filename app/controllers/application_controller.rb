class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :user_signed_in?

  def current_user
    current_teacher || current_student
  end

  def user_signed_in?
    teacher_signed_in? or student_signed_in?
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

end

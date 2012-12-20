class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    current_teacher || current_student
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

end

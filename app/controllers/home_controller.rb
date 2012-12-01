class HomeController < ApplicationController
  def index
    @teachers = Teacher.all
    @students = Student.all
  end
end

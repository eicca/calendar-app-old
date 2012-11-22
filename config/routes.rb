TeacherHelper::Application.routes.draw do
  devise_for :teachers

  devise_for :students

  root :to => "home#index"
end

TeacherHelper::Application.routes.draw do
  resources :lessons

  devise_for :teachers

  devise_for :students

  root :to => "home#index"
end

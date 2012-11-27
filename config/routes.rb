TeacherHelper::Application.routes.draw do
  resources :lessons

  resources :teachers

  devise_for :teachers, path_prefix: 'd'

  devise_for :students, path_prefix: 'd'

  root :to => "home#index"
end

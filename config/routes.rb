TeacherHelper::Application.routes.draw do

  resources :lessons do
    member do
      post 'confirm'
      post 'accept'
      post 'reschedule'
    end
  end

  resources :students, only: [:index, :show] do
    resource :balance, only: [:show, :edit, :update],
      controller: 'StudentBalance'
  end

  resources :teachers do
    resource :balance
    resources :schedules
  end


  devise_for :teachers, path_prefix: 'd'

  devise_for :students, path_prefix: 'd'

  root :to => 'home#index'
end

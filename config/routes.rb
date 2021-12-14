Rails.application.routes.draw do
  get 'static_pages/home'
  resources :categories
  resources :comments
  get 'users/show'
  devise_for :users
  get 'videos/myVideo'

  resources :videos do 
    resources :likes
  end
  
  root to: 'videos#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  controller :videos do
    get 'videos/:id/like' => :like
    get 'videos/:id/dislike' => :dislike 
  end
end

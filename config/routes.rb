Carewell::Application.routes.draw do
  
  devise_for :users
  root 'pages#welcome'

  resources :groups
  resources :tasks
  resources :updates
  resources :locations
  
  get "likes/index"
  get "likes/show"
  get "pages/welcome" => 'pages#welcome', as: 'welcome'
  get "pages/about_us"
end

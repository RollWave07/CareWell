Carewell::Application.routes.draw do
  root 'pages#welcome'
  devise_for :users

  resources :groups
  resources :tasks
  resources :updates
  resources :locations
  
  get "likes/index"
  get "likes/show"
  get "pages/welcome" => 'pages#welcome', as: 'welcome'
  get "pages/about_us"
end

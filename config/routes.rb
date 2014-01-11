Carewell::Application.routes.draw do
  root 'pages#welcome'
  devise_for :users

  resources :groups do
    resources :tasks
    resources :updates
    resources :locations
  end
  
  
  get "likes/index"
  get "likes/show"
  get "pages/welcome" => 'pages#welcome', as: 'welcome'
  get "pages/about_us"
  get "users/index"
end

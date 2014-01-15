Carewell::Application.routes.draw do
  root 'tasks#index'
  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :groups do
    resources :tasks do
      resources :updates do
        member { post :vote }
      end
    end
    resources :locations
  end

  post "/groups/:group_id/tasks/send_email" => 'tasks#send_email', as: 'send_email'
  get "likes/index"
  get "likes/show"
  get "pages/welcome" => 'pages#welcome', as: 'welcome'
  get "pages/about_us"
  get "users/index"
  
end

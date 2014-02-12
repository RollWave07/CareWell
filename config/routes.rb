Carewell::Application.routes.draw do
  get "receivetexts/index"



  post "sendtexts/send_text_message" => 'sendtexts#send_text_message', as: 'send_text'


  devise_for :users, :controllers => {:registrations => "registrations"}

  authenticated :user do
    root :to => "tasks#index", :as => "authenticated_root"
      end

  devise_scope :user do
      root "registrations#new"
    end


  resources :groups do
    resources :tasks do
      member { put :mark_complete }
      resources :updates do
        member { post :vote }
      end
    end
    resources :locations
    get "users/:id" => 'users#show', as: 'user'

  end

  post "/groups/:group_id/tasks/send_email" => 'tasks#send_email', as: 'send_email'
  get "likes/index"
  get "likes/show"
  get "pages/welcome" => 'pages#welcome', as: 'welcome'
  get "pages/about_us"
  get "users/index"
  get "sendtexts/index"
end
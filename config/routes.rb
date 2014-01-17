Carewell::Application.routes.draw do
  get "receivetexts/index"
  get "sendtexts/index"


  post "sendtexts/send_text_message" => 'sendtexts#send_text_message', as: 'send_text'

  root 'pages#welcome'

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

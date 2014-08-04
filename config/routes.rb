Carewell::Application.routes.draw do
  get "receivetexts/index"



  post "sendtexts/send_text_message" => 'sendtexts#send_text_message', as: 'send_text'


  devise_for :users, :controllers => {:registrations => "registrations"}

  authenticated :user do
    root :to => "tasks#index", :as => "authenticated_root"
      end

  devise_scope :user do
      root "registrations#new", :as => "unauthenticated_root"
      get "users/join" => 'registrations#join', as: 'join'
    end

    


  resources :groups do
    resources :events
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

  get "users/email_available"

end



# Routes as of 3 Aug 2014
#                   Prefix Verb   URI Pattern                                                 Controller#Action
#       receivetexts_index GET    /receivetexts/index(.:format)                               receivetexts#index
#                send_text POST   /sendtexts/send_text_message(.:format)                      sendtexts#send_text_message
#         new_user_session GET    /users/sign_in(.:format)                                    devise/sessions#new
#             user_session POST   /users/sign_in(.:format)                                    devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)                                   devise/sessions#destroy
#            user_password POST   /users/password(.:format)                                   devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)                               devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)                              devise/passwords#edit
#                          PATCH  /users/password(.:format)                                   devise/passwords#update
#                          PUT    /users/password(.:format)                                   devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                                     registrations#cancel
#        user_registration POST   /users(.:format)                                            registrations#create
#    new_user_registration GET    /users/sign_up(.:format)                                    registrations#new
#   edit_user_registration GET    /users/edit(.:format)                                       registrations#edit
#                          PATCH  /users(.:format)                                            registrations#update
#                          PUT    /users(.:format)                                            registrations#update
#                          DELETE /users(.:format)                                            registrations#destroy
#       authenticated_root GET    /                                                           tasks#index
#     unauthenticated_root GET    /                                                           registrations#new
#                     join GET    /users/join(.:format)                                       registrations#join
#             group_events GET    /groups/:group_id/events(.:format)                          events#index
#                          POST   /groups/:group_id/events(.:format)                          events#create
#          new_group_event GET    /groups/:group_id/events/new(.:format)                      events#new
#         edit_group_event GET    /groups/:group_id/events/:id/edit(.:format)                 events#edit
#              group_event GET    /groups/:group_id/events/:id(.:format)                      events#show
#                          PATCH  /groups/:group_id/events/:id(.:format)                      events#update
#                          PUT    /groups/:group_id/events/:id(.:format)                      events#update
#                          DELETE /groups/:group_id/events/:id(.:format)                      events#destroy
# mark_complete_group_task PUT    /groups/:group_id/tasks/:id/mark_complete(.:format)         tasks#mark_complete
#   vote_group_task_update POST   /groups/:group_id/tasks/:task_id/updates/:id/vote(.:format) updates#vote
#       group_task_updates GET    /groups/:group_id/tasks/:task_id/updates(.:format)          updates#index
#                          POST   /groups/:group_id/tasks/:task_id/updates(.:format)          updates#create
#    new_group_task_update GET    /groups/:group_id/tasks/:task_id/updates/new(.:format)      updates#new
#   edit_group_task_update GET    /groups/:group_id/tasks/:task_id/updates/:id/edit(.:format) updates#edit
#        group_task_update GET    /groups/:group_id/tasks/:task_id/updates/:id(.:format)      updates#show
#                          PATCH  /groups/:group_id/tasks/:task_id/updates/:id(.:format)      updates#update
#                          PUT    /groups/:group_id/tasks/:task_id/updates/:id(.:format)      updates#update
#                          DELETE /groups/:group_id/tasks/:task_id/updates/:id(.:format)      updates#destroy
#              group_tasks GET    /groups/:group_id/tasks(.:format)                           tasks#index
#                          POST   /groups/:group_id/tasks(.:format)                           tasks#create
#           new_group_task GET    /groups/:group_id/tasks/new(.:format)                       tasks#new
#          edit_group_task GET    /groups/:group_id/tasks/:id/edit(.:format)                  tasks#edit
#               group_task GET    /groups/:group_id/tasks/:id(.:format)                       tasks#show
#                          PATCH  /groups/:group_id/tasks/:id(.:format)                       tasks#update
#                          PUT    /groups/:group_id/tasks/:id(.:format)                       tasks#update
#                          DELETE /groups/:group_id/tasks/:id(.:format)                       tasks#destroy
#          group_locations GET    /groups/:group_id/locations(.:format)                       locations#index
#                          POST   /groups/:group_id/locations(.:format)                       locations#create
#       new_group_location GET    /groups/:group_id/locations/new(.:format)                   locations#new
#      edit_group_location GET    /groups/:group_id/locations/:id/edit(.:format)              locations#edit
#           group_location GET    /groups/:group_id/locations/:id(.:format)                   locations#show
#                          PATCH  /groups/:group_id/locations/:id(.:format)                   locations#update
#                          PUT    /groups/:group_id/locations/:id(.:format)                   locations#update
#                          DELETE /groups/:group_id/locations/:id(.:format)                   locations#destroy
#               group_user GET    /groups/:group_id/users/:id(.:format)                       users#show
#                   groups GET    /groups(.:format)                                           groups#index
#                          POST   /groups(.:format)                                           groups#create
#                new_group GET    /groups/new(.:format)                                       groups#new
#               edit_group GET    /groups/:id/edit(.:format)                                  groups#edit
#                    group GET    /groups/:id(.:format)                                       groups#show
#                          PATCH  /groups/:id(.:format)                                       groups#update
#                          PUT    /groups/:id(.:format)                                       groups#update
#                          DELETE /groups/:id(.:format)                                       groups#destroy
#               send_email POST   /groups/:group_id/tasks/send_email(.:format)                tasks#send_email
#              likes_index GET    /likes/index(.:format)                                      likes#index
#               likes_show GET    /likes/show(.:format)                                       likes#show
#                  welcome GET    /pages/welcome(.:format)                                    pages#welcome
#           pages_about_us GET    /pages/about_us(.:format)                                   pages#about_us
#              users_index GET    /users/index(.:format)                                      users#index
#          sendtexts_index GET    /sendtexts/index(.:format)                                  sendtexts#index
#    users_email_available GET    /users/email_available(.:format)                            users#email_available




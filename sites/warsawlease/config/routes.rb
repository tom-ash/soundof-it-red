Warsawlease::Engine.routes.draw do
  resources :announcements
  get 'route_data', to: 'route_data#show'
  get '/announcements/:id/edit', to: 'announcements#edit'
  get '/announcement/phone/:id', to: 'users#phone'

  get '/pages/:name', to: 'pages#show'
  get '/pages/urls/:url', to: 'pages#show_by_url'

  get '/site_map', to: 'pages#site_map'

  post '/pages', to: 'pages#create'
  put '/pages', to: 'pages#edit'

  get '/svgs', to: 'svgs#index'
  put '/announcements/view/:id', to: 'announcements#view'
  put '/announcements/extend/:id', to: 'announcements#extend_active'
  put '/announcements/trigger_visible/:id', to: 'announcements#trigger_visible'
  get '/calculate_rent_amounts', to: 'announcements#calculate_rent_amounts'
  post '/pictures/create/temporary', to: 'pictures#create_temporary'
  post '/pictures/create/announcement/:id', to: 'pictures#create_for_announcement'
  get '/pictures', to: 'pictures#show'
  get '/phones/verification', to: 'phones#verification'
  post '/testsmslabs', to: 'users#testsmslabs'
  resource :prospective_users, only: :create
  post '/user_create_with_email', to: 'users#create_with_email'
  put '/authorize_with_email', to: 'users#authorize_with_email'
  put '/user/edit/first_name', to: 'users#edit_first_name'
  put '/user/edit/last_name', to: 'users#edit_last_name'
  put '/user/edit/business_name', to: 'users#edit_business_name'
  put '/user/edit/tax_number', to: 'users#edit_tax_number'
  put '/user/edit/phone', to: 'users#edit_phone'
  put '/users/verify_phone', to: 'users#verify_phone'
  put '/user/edit/email/send_current', to: 'users#edit_email_send_current'
  put '/user/edit/email/verify/current', to: 'users#edit_email_verify_current'
  put '/user/edit/email/new', to: 'users#edit_email_send_new'
  put '/user/edit/email/verify/new', to: 'users#edit_email_verify_new'
  put '/user/edit/email', to: 'users#edit_email'
  put '/user/edit/password/email', to: 'users#edit_password_send_email'
  put '/user/edit/password/verification', to: 'users#edit_password_send_verification'
  put '/user/edit/password', to: 'users#edit_password'
  put '/user/destroy/email', to: 'users#destroy_send_email'
  delete '/user/destroy', to: 'users#destroy'
end
Rails.application.routes.draw do
  resources :announcements
  get '/announcements/:id/edit', to: 'announcements#edit'
  get '/announcement/phone/:id', to: 'users#phone'


  resource :prospective_users, only: :create  
  post '/pictures/create/temporary', to: 'pictures#create_temporary'
  post '/pictures/create/announcement/:id', to: 'pictures#create_for_announcement'
  get '/pictures', to: 'pictures#show'

  get '/phones/verification', to: 'phones#verification'
  put '/users/verify_phone', to: 'users#verify_phone'

  put '/announcements/view/:id', to: 'announcements#view'

  post '/testsmslabs', to: 'users#testsmslabs'

  # user edit
  get '/user/edit/account_data', to: 'users#get_account_data'
  put '/user/edit/business_name', to: 'users#edit_business_name'
  put '/user/edit/tax_identification', to: 'users#edit_tax_identification'
  put '/user/edit/phone', to: 'users#edit_phone'


  put '/user/edit/email/send_current', to: 'users#edit_email_send_current'
  put '/user/edit/email/verify/current', to: 'users#edit_email_verify_current'
  put '/user/edit/email/new', to: 'users#edit_email_send_new'


  get '/user_derived_salt', to: 'users#get_derived_salt'
  put '/authorize_with_email_and_password', to: 'users#authorize_with_email_and_password'
  get '/authorize_with_tokens', to: 'users#authorize_with_tokens'
  post '/user_create_with_email', to: 'users#create_with_email'
  

  
  

  put '/user/edit/email/verify/new', to: 'users#edit_email_verify_new'
  put '/user/edit/email', to: 'users#edit_email'
  put '/user/edit/password/email', to: 'users#edit_password_send_email'
  put '/user/edit/password/verification', to: 'users#edit_password_send_verification'
  put '/user/edit/password', to: 'users#edit_password'
  put '/user/destroy/email', to: 'users#destroy_send_email'
  delete '/user/destroy', to: 'users#destroy'
end

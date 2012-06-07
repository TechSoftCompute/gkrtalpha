Bookmarklet::Application.routes.draw do
  resources :categories,:comments, :products
  match "/report_problem"=>"home#report_problem"
  devise_for :users #do
  #   get "sign_in", :to => "devise/sessions#new"
  #   get "sign_out",:to => "devise/sessions#destroy"
  #   get "sign_up",:to => "devise/registrations#new"
  #   get "newsession" ,:to => "sessions#newsession"
  #   get "createsession" ,:to => "sessions#login"
  # end
  root :to => "products#index"
  match "getjson" ,:to => "home#getjson",:as => :getjson
  match "home" ,:to => "home#index",:as => :home
  resources :pages 
  match 'remotecreate' => 'pages#remotecreate', :as => :remotecreate , :via => :get
  match '/fewmoreproducts'=>"products#few_more_products"
  match '/likeproduct'=>"products#like_product"
end

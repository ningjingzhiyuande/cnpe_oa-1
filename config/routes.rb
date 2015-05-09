CnpeNew::Application.routes.draw do

  get "about_us"=>"home#about_us"
  CmsDepartment.kinds.each do |k,v|
  	get "departments/:kind",to: "home_departments#show"
  end
  resources :cms_dang_articles

  resources :cms_dangquns do
  	get :download,on: :member
  end

  resources :cms_departments
  resources :cms_articles

 resources :entretains do 
      member do 
        post :auddit
        get :auddit_from_mail
      end
  end
 resources :loan_goods do 
   get :goods, on: :collection
    member do 
        post :auddit
      #  get :auddit_from_mail
     end
 end

 resources :goods_applies do
    member do 
        post :auddit
      #  get :auddit_from_mail
     end
 end

  

  namespace :statistic do
  get 'leaves/index'
  end
  
  concern :reviewable do
  	resources :reviews 
  end
  concern :loanable do
  	resources :loan_goods 
  end
 concern :appliable do
  	resources :goods_applies 
  end

 resources :goods,concerns: [:reviewable,:appliable,:loanable]
  #match 'leaves/export_data', to: 'leaves#export_data', via: [:get, :post]

  resources :leaves do 
     collection do 
       get :receive
       get :list
       get :export
       get :export_data

     end
     member do 
        post :auddit
        get :auddit_from_mail
     end
  end

  get  "categories/kind/:kind/(:c_id)" => "categories#index"



  
  resources :date_settings 

  get  "date_settings/is_work/:flag" => "date_settings#index"

  resources :categories


  #devise_for :users
  root "home#index"
  #root 'dashboards#index'
  #devise_for :users, path: "auth"#, path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  devise_for :users, :controllers => {:registrations => "registrations",sessions: "sessions"},path_names: {sign_out: 'logout'}

  get  "users/approve/:is_approve" =>"users#index"
  resources :users do 
     member do 
        get :approve
        get :hr
        get :unhr
     end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

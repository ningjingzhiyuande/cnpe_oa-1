CnpeNew::Application.routes.draw do

  resources :pre_goods do 
  	post :order ,on: :collection
  	get :orders,on: :collection
  	get :order_show,on: :collection
  	get :auddit,on: :collection
  end

  resources :cms_notices

  resources :home_notifications
  resources :home_lianjies

  get "home_lanjies" ,to: "home_dang_articles#lianjies"

  resources :cms_homes

  resources :home_dang_articles

  
  resources :home_department_articles

  #get "about_us"=>"home#about_us"
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
      get :statistics,on: :collection
  end
 resources :loan_goods do 
   get :goods,:list, on: :collection
    member do 
        post :auddit
      #  get :auddit_from_mail
     end
 end

 resources :goods_applies do
 	get :list, on: :collection
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

 resources :goods,concerns: [:reviewable,:appliable,:loanable] do
 	get :apply_analysis,on: :collection
 	get :loan_analysis,on: :collection

 end
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

  resources :dashboards

  
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

end

Rails.application.routes.draw do
  resources :contacts
  resources :transactions
  resources :merchants
  resources :nominees
  resources :categories
  resources :awards
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "home#dashboard"
  get 'about' =>'home#about'
  get 'contact' =>'home#contact'
  get 'voting'=> 'home#voting'
  get 'vote_category'=> 'home#vote_category'
  get 'vote_nominee'=>  'home#vote_nominee'
  get 'vote_pay'=> 'home#vote_pay'
  get 'visa_callback' => 'home#visa_callback'
  post 'payme_user' => 'transactions#payme_user'
  post 'contact_us' =>        'home#contact_us'
  
end

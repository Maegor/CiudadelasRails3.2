CiudadelsRails32::Application.routes.draw do



  get 'waiting_rooms/leave'

  match 'home/get_menu' => 'home#get_menu'

   match '/parties/join/:id' => 'parties#join'
   match '/parties/:party_id/select_card/:card_id' => 'parties#select_card'
   match '/parties/take_coins/:party_id' => 'parties#take_coins'
   match '/parties/:party_id/select_district/:card_id' => 'parties#select_district'
   match '/parties/build_district/:card_id' => 'parties#build_district'
   match '/parties/end_turn/' => 'parties#end_turn', :as => :end_turn
   match '/parties/:party_id/cards/:card_id/murder' => 'parties#murder'
   match '/parties/:party_id/cards/:card_id/steal' => 'parties#steal'
   match '/parties/:party_id/change_with_maze' => 'parties#change_with_maze'
   match '/parties/:party_id/change_with_player' => 'parties#change_with_player'
   match ':party_id/change_cards' => 'parties#change_cards', :via => :post
   match ':party_id/exchange_cards' => 'parties#exchange_cards', :via => :post
   match '/parties/test' => 'parties#test'
   match '/parties/:party_id/destroy_building/:card_id' => 'parties#destroy_building'
   #match '/parties/:party_id/resumen' => 'parties#resumen'

  resources :users  do
    collection do
      get 'testt'
    end

  end
  resources :sessions


  resources :waiting_rooms do

    member do
     get 'start'
     get 'join'
     get 'leave'
    end


  end

   resources :parties, :except => [:index] do
     get 'leave_game'
     get 'resumen'
     get 'action(/*path)' => 'actions#action', :as => :action
     post 'action(/*path)' => 'actions#action', :as => :action

=begin
     resources :cards do
       get 'murder'
     end
=end
   end

   resources :players do

     get 'take_taxes'
     get 'take_extra_gold'
     get 'take_districts'
     get 'take_extra_cards'
   end

   controller :parties do
     get 'game' => :game
     post 'create_party' => :create
     delete 'destroy_party' => :delete
   end

   
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/show.html.
    root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

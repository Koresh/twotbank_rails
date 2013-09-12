TwotbankRails::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'live#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  #live
  get 'live' => 'live#index'
  get 'credit-transfer'   => 'live#credit_transfer'
  get 'schet-dlya-zhizni' => 'live#schet_dlya_zhizni'
  get 'debetovye-karty'   => 'live#debetovye_karty'
  get 'credit-account'    => 'live#credit_account'
  get 'tvklad'            => 'live#tvklad'
  get 'vklad-na-srok'     => 'live#vklad_na_srok'
  get 'safebox'           => 'live#safebox'
  get 'mortgage'          => 'live#mortgage'
  get 'new-moscow'        => 'live#new_moscow'
  get 'mobile'            => 'live#mobile'
  get 'recharge'          => 'live#recharge'
  get 'cash-withdrawal'   => 'live#cash_withdrawal'
  get 'internet-bank'     => 'live#internet_bank'
  get 'contacts'          => 'contacts#index'
  get 'credit-landing'    => 'live#credit_landing'

  #o-banke
  get 'o-banke'            => 'o_banke#index'
  get 'o-banke/requisites' => 'o_banke#requisites'
  get 'o-banke/info'       => 'o_banke#info'
  get 'o-banke/financial-statements'  => "o_banke#financial_statements"
  get 'ajax/geo/offices/:city_id'     => 'api#offices'

  #press-centre
  get 'press-centre'           => 'press_centre#index'
  get 'press-centre/press'     => 'press_centre#press'
  get 'press-centre/news'      => 'press_centre#news'
  get 'press-centre/press/155' => 'press_centre#news_item'

  #business
  get 'business'                    => 'business#index'
  get 'business/schet-dlya-biznesa' => 'business#schet_dlya_biznesa'
  get 'business/acquiring'          => 'business#acquiring'
  get 'business/business-card'      => 'business#business_card'
  get 'business/encashment-card'    => 'business#encashment_card'
  get 'business/internet-acquiring' => 'business#internet_acquiring'
  get 'business/overdraft'          => 'business#overdraft'
  get 'business/salary'             => 'business#salary'
  get 'business/schet-dlya-biznesa' => 'business#schet_dlya_biznesa'
  get 'business/sms'                => 'business#sms'
  get 'business/vklad-na-srok'      => 'business#vklad_na_srok'
  get 'business/documents-and-rates' => 'business#documents_and_rates'
  get 'business/dohodniy-schet-dlya-biznesa' => 'business#dohodniy_schet_dlya_biznesa'
  
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

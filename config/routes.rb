TwotbankRails::Application.routes.draw do
  get "errors/error_404"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'live#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  #live
  get 'live' => 'live#index'
  get 'credit-transfer'     => 'live#credit_transfer'
  get 'schet-dlya-zhizni'   => 'live#schet_dlya_zhizni'
  get 'debetovye-karty'     => 'live#debetovye_karty'
  get 'credit-account'      => 'live#credit_account'
  get 'dohodniy-schet-plus' => 'live#dohodniy_schet_plus'
  get 'vklad-na-srok'       => 'live#vklad_na_srok'
  get 'safebox'             => 'live#safebox'
  get 'mortgage'            => 'live#mortgage'
  get 'new-moscow'          => 'live#new_moscow'
  get 'mobile'              => 'live#mobile'
  get 'recharge'            => 'live#recharge'
  get 'cash-withdrawal'     => 'live#cash_withdrawal'
  get 'internet-bank'       => 'live#internet_bank'
  get 'contacts'            => 'contacts#index'
  get 'credit-landing'      => 'live#credit_landing'

  #live
  #o-banke
  get 'o-banke'            => 'live/o_banke#index'
  get 'o-banke/requisites' => 'live/o_banke#requisites'
  get 'o-banke/info'       => 'live/o_banke#info'
  get 'o-banke/financial-statements'  => "live/o_banke#financial_statements"
  get 'o-banke/registry-rules'        => "live/o_banke#registry_rules"
  get 'ajax/geo/offices/:city_id'     => 'api#offices'

  #business
  #o-banke
  get 'business/o-banke'            => 'business/o_banke#index'
  get 'business/o-banke/requisites' => 'business/o_banke#requisites'
  get 'business/o-banke/info'       => 'business/o_banke#info'
  get 'business/o-banke/financial-statements'  => "business/o_banke#financial_statements"
  get 'business/o-banke/registry-rules'        => "business/o_banke#registry_rules"


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
  get 'business/special/buhsoft'    => 'business#buhsoft'

  #404
  get '*not_found' => 'errors#error_404' #unless Rails.application.config.consider_all_requests_local
  
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

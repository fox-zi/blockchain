Rails.application.routes.draw do
  namespace :block_chain do
    get :mine
    post :new_transaction
    get :full_chain
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

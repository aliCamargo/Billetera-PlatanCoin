Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'accounts#index'
  get 'cuentas/:address', to: 'accounts#show', as: 'show_account'
  post 'cuentas/:address/tx', to: 'accounts#add_transaction', as: 'add_transaction'
end

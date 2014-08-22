Rails.application.routes.draw do
  root to: 'visitors#index'
  get 'works/:work_type/new', to: 'works#new', as: :new_work
end

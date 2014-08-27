Rails.application.routes.draw do
  root to: 'visitors#index'
  get 'works/:work_type/new', to: 'works#new', as: :new_work
  get 'works/available_types', to: 'works#available_types', as: :available_work_types
  post 'works/:work_type', to: 'works#create', as: :works
  get 'works/show/:id', to: 'works#show', as: :work
end

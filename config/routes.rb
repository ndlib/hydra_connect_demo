Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'visitors#index'

  # These routes are hand crafted instead of using the ubiquitous `resource :works`
  get 'works/available_types', to: 'works#available_types', as: :available_work_types
  get 'works', to: 'works#index', as: :works
  get 'works/:work_type/new', to: 'works#new', as: :new_work
  post 'works/:work_type', to: 'works#create', as: :create_work
  get 'works/:id', to: 'works#show', as: :work
  get 'works/:id/edit', to: 'works#edit', as: :edit_work
  patch 'works/:id', to: 'works#update', as: :update_work
  put 'works/:id', to: 'works#update' # An alias for :update_work
end

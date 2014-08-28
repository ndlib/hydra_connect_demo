Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'visitors#index'

  # These routes are hand crafted instead of using the ubiquitous `resource :works`
  get 'works/:work_type/new', to: 'works#new', as: :new_work
  get 'works/available_types', to: 'works#available_types', as: :available_work_types
  post 'works/:work_type', to: 'works#create', as: :works
  get 'works/show/:id', to: 'works#show', as: :work
  get 'works/edit/:id', to: 'works#edit', as: :edit_work
end

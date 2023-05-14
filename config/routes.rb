Rails.application.routes.draw do
  get 'exercises/new'
  get 'exercises/create'
  # get 'articles/index'
  # get 'articles/new'
  # get 'articles/create'
  # get 'articles/show'
  # get 'articles/edit'
  # get 'articles/update'
  # get 'articles/destroy'
  # get 'trainings/index'
  # get 'trainings/new'
  # get 'trainings/create'
  # get 'trainings/show'
  # get 'trainings/edit'
  # get 'trainings/update'
  # get 'trainings/destroy'
  # get 'patients/index'
  # get 'patients/new'
  # get 'patients/create'
  # get 'patients/show'
  # get 'patients/edit'
  # get 'patients/update'
  # get 'patients/destroy'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :patients, only: [:new, :create, :show]
  resources :trainings, only: [:new, :create, :show]
  resources :training_sets
  resources :articles
  resources :exercises do
    get 'search', on: :collection
  end
  resources :exercises, only: [:new, :create, :show, :edit]
  root 'patients#index'
end

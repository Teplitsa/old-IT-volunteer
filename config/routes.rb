# encoding: utf-8

Volunteer::Application.routes.draw do
  
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: "registrations"}
  
  root to: 'home#index'

  resources :tasks do
    member do
      get :apply
      get 'assign/:user_id' => 'tasks#assign', as: 'assign_user'
      
      Task::ROLES.each do |role|
        delete "kick_#{role}/:user_id" => "tasks#kick_#{role}", as: "kick_#{role}"
      end

      put 'state/:state' => 'tasks#change_state', as: :change_state
      put :feedback
    end

    resources :comments, only: [:new, :create, :destroy]
  end

  resources :organizations do
    member do
      put :invite_user

      Organization::ROLES.each do |role|
        delete "kick_#{role}/:user_id" => "organizations#kick_#{role}", as: "kick_#{role}"
      end
    end

    resources :comments, only: [:new, :create, :destroy]
    resources :tasks, only: [:index]
  end

  resources :task_types, only: [] do
    put 'prefer' => 'preferences#prefer'
    put 'unprefer' => 'preferences#unprefer'
  end

  resources :prize_types, only: [] do
    put 'prefer' => 'preferences#prefer'
    put 'unprefer' => 'preferences#unprefer'
  end
  
  resources :users do
    member do
      put :ignore
      put :unignore
    end

    resources :comments, only: [:index, :new, :create, :destroy]
    resources :tasks,    only: :index
  end

  resources :pages, only: :show

  resources :messages, except: [:index, :show]

  get 'dialogs' => 'messages#dialogs',          as: :dialogs
  get 'dialogs/:dialog_id' => 'messages#index', as: :dialog

  post 'messages' => 'messages#create', as: :messages
end

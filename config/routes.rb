Rails.application.routes.draw do
  namespace :api do
   resources :people do
    resources :tasks
  end
  # override some CRUD's
  resources :tasks, :except => ['show', 'update', 'destroy']
  # Additionals functions routes
    get 'tasks/:id' => 'tasks#get_task_by_id'
    patch 'tasks/:id' => 'tasks#set_task_by_id'
    delete 'tasks/:id' => 'tasks#del_task_by_id'
    get 'tasks/:id/owner' => 'tasks#get_owner_id'
    put 'tasks/:id/owner' => 'tasks#set_owner_id'
    get 'tasks/:id/status' => 'tasks#get_status'
    put 'tasks/:id/status' => 'tasks#set_status'   
  end
end 
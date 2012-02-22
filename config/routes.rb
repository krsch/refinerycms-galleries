::Refinery::Application.routes.draw do
  resources :galleries, :only => [:index, :show]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :galleries, :except => :show do
      collection do
        post :update_positions
      end
      member do
        get :upload, :to => 'galleries#upload_new'
        put :upload
      end
      match 'image/:image_name', :to => 'galleries#delete_image', :via => :delete, :on => :member
    end
  end
end

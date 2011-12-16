::Refinery::Application.routes.draw do
  resources :galleries, :only => [:index, :show]

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :galleries, :except => :show do
      collection do
        post :update_positions
      end
    end
  end
end

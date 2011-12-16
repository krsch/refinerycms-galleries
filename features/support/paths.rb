module NavigationHelpers
  module Refinery
    module Galleries
      def path_to(page_name)
        case page_name
        when /the list of galleries/
          admin_galleries_path

         when /the new gallery form/
          new_admin_gallery_path
        else
          nil
        end
      end
    end
  end
end

require 'refinerycms-base'

module Refinery
  module Galleries

    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end
    end

    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "galleries"
          plugin.pathname = root
	  plugin.hide_from_menu = false
          plugin.activity = {
            :class => Gallery,
	    :title => 'page.title'
          }
        end
      end
      config.to_prepare do
        Page.module_eval do
	  has_one :gallery
	end
      end
    end
  end
end


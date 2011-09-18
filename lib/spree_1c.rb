require 'spree_core'

module Spree1c
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      Api::BaseController.class_eval do
        respond_to :json, :xml
      end

    end

    config.to_prepare &method(:activate).to_proc
  end
end

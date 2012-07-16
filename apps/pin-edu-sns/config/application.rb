require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(:default, :assets, Rails.env)
end

module MindpinEduSns
  class Application < Rails::Application
    # load mindpin lib
    require "#{Rails.root}/../../lib/mindpin_rails_loader"
    MindpinRailsLoader.new(config).load
  end
end

require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module R7Additional
  class Application < Rails::Application
    config.load_defaults 7.0
    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
  end
end

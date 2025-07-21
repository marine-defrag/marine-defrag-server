# frozen_string_literal: true

require_relative "boot"

require "rails/all"

require_relative '../lib/middleware/block_trace_requests'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HumanRightsNationalReporting
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Ensure non-standard paths are eager-loaded in production
    # (these paths are also autoloaded in development mode)
    config.eager_load_paths += %W(#{config.root}/lib)
    # Add lib folder to autoload paths
    config.autoload_paths << Rails.root.join('lib')

    config.time_zone = "Berlin"
    config.active_record.default_timezone = :local

    config.middleware.insert_before 0, BlockTraceRequests

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"
        resource "*", headers: :any, methods: :any, expose: ["access-token", "expiry", "token-type", "uid", "client"]
      end
    end

    config.middleware.use BatchApi::RackMiddleware do |batch_config|
      # you can set various configuration options:
      batch_config.verb = :post # default :post
      batch_config.endpoint = "/batchapi" # default /batch
      batch_config.limit = 200 # how many operations max per request, default 50

      # default middleware stack run for each batch request
      batch_config.batch_middleware = proc {}
      # default middleware stack run for each individual operation
      batch_config.operation_middleware = proc {}
    end

    config.active_record.belongs_to_required_by_default = true

    config.load_defaults 7.2
  end
end

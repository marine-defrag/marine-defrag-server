# frozen_string_literal: true

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = true

  # Configure public file server for tests with Cache-Control for performance.
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # Show full error reports and disable caching.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this.
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # Raise exceptions instead of rendering exception templates.
  # config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  # config.action_controller.allow_forgery_protection = false

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = false

  # Use the lowest log level to ensure availability of diagnostic information
  # when problems arise.
  config.log_level = :debug

  # Prepend all log lines with the following tags.
  config.log_tags = [:request_id]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment)
  # config.active_job.queue_adapter     = :resque
  # config.active_job.queue_name_prefix = "human-rights-national-reporting_#{Rails.env}"
  config.action_mailer.perform_caching = false

  # Production SMTP config
  config.action_mailer.perform_deliveries = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    port: ENV["SMTP_PORT"],
    address: ENV["SMTP_SERVER"],
    user_name: ENV["SMTP_LOGIN"],
    password: ENV["SMTP_PASSWORD"],
    domain: ENV["SMTP_DOMAIN"],
    authentication: :plain,
    enable_starttls_auto: true,
    openssl_verify_mode: "none",
    ssl: true,
    tls: true
  }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = {
    host: ENV["ACTION_MAILER_HOST"],
    protocol: ENV["ACTION_MAILER_PROTOCOL"] || "https"
  }
  config.action_mailer.asset_host = ENV["ACTION_MAILER_ASSET_HOST"]

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Use a different logger for distributed setups.
  # require 'syslog/logger'
  # config.logger = ActiveSupport::TaggedLogging.new(Syslog::Logger.new 'app-name')

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new($stdout)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end

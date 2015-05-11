require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module CnpeNew
  class Application < Rails::Application
  	config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
  "#{html_tag}".html_safe
}
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
     config.i18n.default_locale = "zh-CN"
     config.active_record.raise_in_transactional_callbacks=true
     config.action_mailer.default_url_options = { host: 'http://192.81.135.229' }
     config.assets.precompile += ['leaves.js',"jquery.datetimepicker.js","jquery.datetimepicker.css","jquery-ui.multidatespicker.js","ie7.css","ie6.css","pngfix.js",'cms.js','cms.css']
    # config.active_job.queue_adapter = :delayed_job
  end
end

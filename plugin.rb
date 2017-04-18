# name: zendesk
# about: create and view status of zendesk ticket within each topic
# authors: shiv kumar

gem 'scrub_rb', '1.0.1'

gem 'inflection', '1.0.0'
gem 'zendesk_api', '1.14.0'


#register_asset "javascripts/topic_route_cont.js"
register_asset "javascripts/zendesk_button.js"
register_asset "stylesheets/buttons_cont.css.scss"

after_initialize do
  load File.expand_path("../controllers/zendesk_controller.rb", __FILE__)
  load File.expand_path("../lib/zendesk_ticket.rb", __FILE__)
  load File.expand_path("../lib/new_zendesk_ticket.rb", __FILE__)
  load File.expand_path("../lib/existing_zendesk_ticket.rb", __FILE__)

  Discourse::Application.routes.prepend do
    post 'zendesk/create_ticket' => 'zendesk#create_ticket'
    get 'zendesk/find_ticket' => 'zendesk#find_ticket'
  end
end

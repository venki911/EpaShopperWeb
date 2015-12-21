# Load the Rails application.
require File.expand_path('../application', __FILE__)

env_variables = File.join(Rails.root, 'config', 'initializers', 'environment_variables.rb')
load(env_variables) if File.exists?(env_variables)

# Initialize the Rails application.
Rails.application.initialize!

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
GreatWork::Application.initialize!

TASK_STATUS = {:in_progress => 1, :completed => 2, :canceled => 3}
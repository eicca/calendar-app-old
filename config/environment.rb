# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
TeacherHelper::Application.initialize!
Footnotes::Filter.prefix = 'mvim://open?url=file://%s&line=%d&column=%d'

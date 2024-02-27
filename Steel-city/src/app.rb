# Gems
require "require_all"
require "sinatra"
require "logger"
require "sequel"

# So we can escape HTML special characters in the view
include ERB::Util

# Sessions
enable :sessions

# App
require_rel "controllers"

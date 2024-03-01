# Gems
require "require_all"
require "sinatra"
require "logger"
require "sequel"
require "sqlite3"

# So we can escape HTML special characters in the view
include ERB::Util

# Database
mode = ENV.fetch("APP_ENV", "development")
path = File.dirname(__FILE__)
file_minus_ext = "#{path}/#{mode}"

DB = Sequel.sqlite("database.sqlite3")

# Sessions
enable :sessions

# App
require_rel "controllers"

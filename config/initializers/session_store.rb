# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_naive-ad-server_session',
  :secret      => '287d3302007a81d2a2e8e36534eaa7512c890609430167e82b04fc67dce2ba75033cbc02f880ec72f65063215cae342d8a386cded20d0478bcfc022ea4a92b25'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

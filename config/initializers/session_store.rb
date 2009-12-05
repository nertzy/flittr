# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_flittr_session',
  :secret      => '8ba5710dcd358a66a6031b5e2d64287c97b5d54ec36ab2c1b849e4c5e7bda4cbf1bbf4fa96ba785d94c4ebd2229078d984e3855cce23aa985a71d513fc08dab5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

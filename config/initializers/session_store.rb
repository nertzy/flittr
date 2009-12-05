# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_flittr_session',
  :secret      => 'aca95b5637b8d20f9163014183bc0d6c7ce4822d24b5b565cb0d1f0afb175c96d27352f62827d10a21bb5b9087621d8c54ffbfccb338fd016823e29a4bbf799f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

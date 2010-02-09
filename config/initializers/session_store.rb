# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_twiborg_session',
  :secret      => 'c5d12a5a26528ba602b055570eeae4ceb4ee327ee9993b83866801f5052e34bb40a9ca56ace6270a149213d543a8a8b55011173cc5d85dd581616f6f8fe34569'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

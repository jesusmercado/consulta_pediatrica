# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_consulta_pediatrica_session',
  :secret      => 'fa47b6da14d293eb7a130b28747bca425e276e1140078ac1e617db8dfc164a9d25303936f18fb9d43d9296897e338666d1cfff010378ba3b6ea0ce6f0a47011a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

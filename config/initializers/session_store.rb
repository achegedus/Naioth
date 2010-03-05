# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_EnergyCAP_SaaS_session',
  :secret      => 'c6e54ab891f159eac0c0d95b79177bfd5608f6c8b0ea5d6b96b4b1a9f460ad894f93af0c35ee1128c16027bf2b38fd12d3e5415452c97c4ba0085421c0c29520'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

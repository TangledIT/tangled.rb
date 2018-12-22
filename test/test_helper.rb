$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'tangled'

require 'byebug'
require 'minitest/autorun'
require 'webmock/minitest'

# Enable line below to test on actual node
# WebMock.disable!

# Set test config
Tangled.configure do |config|
  config.node = 'https://nodes.testnet.iota.org:443'
end

# Stub IRI requests
require 'support/stubbed_iri'

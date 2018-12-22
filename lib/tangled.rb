require 'iota'
require 'string'

require 'tangled/version'
require 'tangled/config'
require 'tangled/node'
require 'tangled/seed'
require 'tangled/account'
require 'tangled/transaction'
require 'tangled/transfer'

# Tangled
module Tangled
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Config.new
    yield(config)
  end

  def self.util
    @util ||= IOTA::Utils::Utils.new
  end
end

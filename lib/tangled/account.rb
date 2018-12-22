module Tangled
  # Account
  class Account
    attr_reader :balance, :latest_address, :addresses, :inputs

    def initialize(seed)
      @seed = seed
      @account = IOTA::Models::Account.new(Tangled::Node.new.client, seed)
      refresh
    end

    def refresh
      details = @account.getAccountDetails
      @balance = details.balance
      @latest_address = details.latestAddress
      @addresses = details.addresses
      @inputs = details.inputs
    end

    def generate_address
      address = @account.getNewAddress(checksum: true)
      create_transfer(address) # Add address to Tangle
      address
    end

    def create_transfer(address, message = nil, value = 0)
      transfers = [{
        address: address,
        value: value,
        message: Tangled.util.toTrytes(message)
      }]
      transactions =
        @account.sendTransfer(Tangled.config.depth,
                              Tangled.config.min_weight_magnitude,
                              transfers)
      transactions.map do |transaction|
        Transaction.new(transaction)
      end
    end

    def transfers
      @account.getAccountDetails.transfers.map do |transfer|
        Transfer.new(transfer)
      end
    end
  end
end

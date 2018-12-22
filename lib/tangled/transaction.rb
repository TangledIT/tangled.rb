module Tangled
  # Transaction
  class Transaction
    attr_reader :transaction, :node, :hash, :signature_message_fragment,
                :address, :value, :obsolete_tag, :timestamp, :current_index,
                :last_index, :bundle, :trunk_transaction, :branch_transaction,
                :tag, :attachment_timestamp, :nonce, :persistence,
                :attachment_timestamp_lower_bound,
                :attachment_timestamp_upper_bound

    def initialize(transaction)
      @node = Tangled::Node.new
      @transaction = transaction

      assign_transaction
    end

    def message
      Tangled.util.fromTrytes(
        @signature_nessage_fragment.gsub(/9*$/, '')
      )
    end

    def valid?
      @transaction.valid?
    end

    def confirmed?
      return false unless @node.synced?

      inclusion_state =
        @node.client.api.getLatestInclusion([@hash])
      return false unless inclusion_state[0]

      return true if inclusion_state[1].first

      false
    end

    private

    # rubocop:disable Metrics/AbcSize
    def assign_transaction
      @hash = transaction.hash
      @signature_message_fragment =
        transaction.signatureMessageFragment
      @address = transaction.address
      @value = transaction.value
      @obsolete_tag = transaction.obsoleteTag
      @timestamp = transaction.timestamp
      @current_index = transaction.currentIndex
      @last_index = transaction.lastIndex
      @bundle = transaction.bundle
      @trunk_transaction = transaction.trunkTransaction
      @branch_transaction = transaction.branchTransaction
      @tag = transaction.tag
      @attachment_timestamp = transaction.attachmentTimestamp
      @attachment_timestamp_lower_bound =
        transaction.attachmentTimestampLowerBound
      @attachment_timestamp_upper_bound =
        transaction.attachmentTimestampUpperBound
      @nonce = transaction.nonce
      @transaction.persistence = nil
    end
    # rubocop:enable Metrics/AbcSize
  end
end

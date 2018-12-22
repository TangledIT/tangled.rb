require 'test_helper'

class AccountTest < Minitest::Test
  def setup
    @seed = Tangled::Seed.generate
    WebMock.stub_request(:post, Tangled.config.node).to_rack(StubbedIri)
    @account = Tangled::Account.new(@seed)
  end

  def test_if_account_info_exists
    assert_equal @account.balance, 0
    assert_equal @account.transfers, []
  end

  def test_adding_a_address
    address = @account.generate_address
    assert address.size, 81
  end

  def test_transferring_a_message
    seed_to = Tangled::Seed.generate
    account_to = Tangled::Account.new(seed_to)

    address = account_to.generate_address
    transactions = @account.create_transfer(address, 'tangled')
    assert transactions.first.valid?
    assert_equal transactions.size, 1
  end
end

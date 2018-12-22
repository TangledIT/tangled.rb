require 'test_helper'

class NodeTest < Minitest::Test
  def setup
    WebMock.stub_request(:post, Tangled.config.node).to_rack(StubbedIri)
  end

  def test_if_node_is_synced
    node = Tangled::Node.new
    assert node.synced?
  end

  def test_if_node_info_exists
    status = Tangled::Node.new.info
    assert_equal 'IRI Testnet', status['app_name']
    assert status['tips'] > 0
  end

  def test_fetch_neighbors
    neighbors = Tangled::Node.new.neighbors
    assert_equal 2, neighbors.size
    assert neighbors.first['address']
  end

  def test_if_node_has_url
    assert_equal Tangled::Node.new.url, Tangled.config.node
  end
end

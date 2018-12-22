require 'sinatra/base'
require 'uri'

class StubbedIri < Sinatra::Base
  before do
    request.body.rewind
    @body = JSON.parse request.body.read
  end

  post '/' do
    data = case @body['command']
           when 'getNodeInfo' then response_get_node_info
           when 'wereAddressesSpentFrom' then respose_spent_from
           when 'findTransactions' then response_find_transactions
           when 'getTransactionsToApprove' then response_approve
           when 'getBalances' then response_get_balances
           when 'attachToTangle' then response_attach_to_tangle
           when 'getNeighbors' then response_get_neighbors
           when 'storeTransactions', 'broadcastTransactions' then {}
           else
             {}
           end

    json_response(200, data)
  end

  private

  def response_get_neighbors
    {
      'duration': 37,
      'neighbors': [
        {
          'address': '/8.8.8.8:14265',
          'numberOfAllTransactions': 922,
          'numberOfInvalidTransactions': 0,
          'numberOfNewTransactions': 92
        },
        {
          'address': '/8.8.8.8:5000',
          'numberOfAllTransactions': 925,
          'numberOfInvalidTransactions': 0,
          'numberOfNewTransactions': 20
        }
      ]
    }
  end

  def response_attach_to_tangle
    { trytes: [File.read('test/fixtures/trytes.txt').strip] }
  end

  def response_get_balances
    {
      'balances': ['0'],
      'duration': 30,
      'references': ['INRTUYSZCWBHGFGGXXPWRWBZACYAFGVRRP9VY' \
                     'EQJOHYD9URMELKWAFYFMNTSP9MCHLXRGAFMBOZPZ9999'],
      'milestoneIndex': 128
    }
  end

  def response_approve
    {
      'trunkTransaction': 'TKGDZ9GEI9CPNQGHEATIISAKYPPP' \
                          'SXVCXBSR9EIWCTHHSSEQCD9YLDPE' \
                          'XYERCNJVASRGWMAVKFQTC9999',
      'branchTransaction': 'TKGDZ9GEI9CPNQGHEATIISAKYPP' \
                           'PSXVCXBSR9EIWCTHHSSEQCD9YLD' \
                           'PEXYERCNJVASRGWMAVKFQTC9999',
      'duration': 936
    }
  end

  def response_find_transactions
    { hashes: [] }
  end

  def respose_spent_from
    {
      states: @body['addresses'].map { false },
      duration: 1
    }
  end

  def response_get_node_info
    {
      'appName': 'IRI Testnet',
      'appVersion': '1.5.5',
      'duration': 1,
      'jreAvailableProcessors': 4,
      'jreFreeMemory': 91_707_424,
      'jreMaxMemory': 1_908_932_608,
      'jreTotalMemory': 122_683_392,
      'latestMilestone': '9999999999999999',
      'latestMilestoneIndex': 107,
      'latestSolidSubtangleMilestone': '9999999999999999',
      'latestSolidSubtangleMilestoneIndex': 107,
      'neighbors': 2,
      'packetsQueueSize': 0,
      'time': 1_477_037_811_737,
      'tips': 3,
      'transactionsToRequest': 0
    }
  end

  def json_response(response_code, data)
    content_type :json
    status response_code
    data.to_json
  end
end

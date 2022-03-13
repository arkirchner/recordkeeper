# frozen_string_literal: true

require 'test_helper'

class ImportOsmosisTransactionsJobTest < ActiveJob::TestCase
  test 'imports transaction for wallet' do
    wallet = Osmosis::Wallet.create!(address: 'osmo186y4suz4z87v6s6ecd6552alnef4fdmuhrnn9a')

    body = JSON.parse(file_fixture('transactions.json').read)

    stub_request(:get, 'https://api-osmosis-chain.imperator.co/txs/v1/tx/address/osmo186y4suz4z87v6s6ecd6552alnef4fdmuhrnn9a?limit=2&offset=1')
      .to_return(status: 200, body:)

    assert_changes 'Osmosis::Transaction.count', 2 do
      ImportOsmosisTransactionsJob.perform_now(wallet)
    end
  end
end

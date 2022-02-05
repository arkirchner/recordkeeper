# frozen_string_literal: true

require 'test_helper'

class CoinTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test '.import, it inserts a coint to the database' do
    coin = {
      id: 'cardano',
      symbol: 'ada',
      name: 'Cardano'
    }

    stub_request(:get, 'https://api.coingecko.com/api/v3/coins/cardano')
      .to_return(status: 200, body: coin.to_json)

    Coin.import('cardano')

    assert Coin.exists?(coin), 'Did not import Cardano coin.'
  end

  test '.update_ohlc' do
    cardano = Coin.create!(id: 'cardano', symbol: 'ada', name: 'Cardano')
    cosmos = Coin.create!(id: 'cosmos', symbol: 'atom', name: 'Cosmos')

    Coin.update_ohlc

    assert_enqueued_with(job: OhlcImportJob, args: [cardano])
    assert_enqueued_with(job: OhlcImportJob, args: [cosmos])
  end
end

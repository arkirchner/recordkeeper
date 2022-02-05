# frozen_string_literal: true

require 'test_helper'

class CoinTest < ActiveSupport::TestCase
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
end

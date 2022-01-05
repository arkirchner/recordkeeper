# frozen_string_literal: true

require 'test_helper'

class CoinTest < ActiveSupport::TestCase
  setup do
    coins = [
      {
        id: 'cardano',
        symbol: 'ada',
        name: 'Cardano'
      },
      {
        id: 'cosmos',
        symbol: 'atom',
        name: 'Cosmos'
      }
    ]

    stub_request(:get, 'https://api.coingecko.com/api/v3/coins/list')
      .to_return(status: 200, body: coins.to_json)
  end

  test '.import, it inserts coints to the database' do
    assert_difference 'Coin.count', 2 do
      Coin.import
    end
  end

  test '.import, it adds new coins' do
    Coin.import

    coin = {
      id: 'polkadot',
      symbol: 'dot',
      name: 'Polkadot'
    }

    stub_request(:get, 'https://api.coingecko.com/api/v3/coins/list')
      .to_return(status: 200, body: [coin].to_json)

    assert_difference 'Coin.where(coin).count', 1 do
      Coin.import
    end

    assert_equal(3, Coin.count)
  end
end

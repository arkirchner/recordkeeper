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

  test '.set_current_values, sets current price and 25h change' do
    cardano = Coin.create!(id: 'cardano', symbol: 'ada', name: 'Cardano')
    cosmos = Coin.create!(id: 'cosmos', symbol: 'atom', name: 'Cosmos')

    prices = {
      cardano: {
        usd: 1.15,
        usd_24h_change: -2.64
      },
      cosmos: {
        usd: 29.07,
        usd_24h_change: -4.12
      }
    }

    api_url = 'https://api.coingecko.com/api/v3/simple/price?ids=cardano,cosmos' \
              '&include_24hr_change=true&vs_currencies=usd'

    stub_request(:get, api_url).to_return(status: 200, body: prices.to_json)

    Coin.set_current_values

    assert_in_delta(cardano.current_price.value, 1.15)
    assert_in_delta(cosmos.twenty_four_hours_change.value, -4.12)
  end
end

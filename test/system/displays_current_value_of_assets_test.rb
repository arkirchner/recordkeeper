# frozen_string_literal: true

require 'application_system_test_case'

class DisplaysCurrentValueOfAssetsTest < ApplicationSystemTestCase
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

    cardano, cosmos = Coin.create!(coins)

    user = User.create!

    cardano.current_price.value = 1.34
    cardano.twenty_four_hours_change.value = -4.35865
    cosmos.current_price.value = 24.36
    cosmos.twenty_four_hours_change.value = +3.27278

    Asset.create!(user:, coin: cardano, amount: 5678.1235)
    Asset.create!(user:, coin: cosmos, amount: 78.54321)
  end

  test 'each asset is displayed with current total holdings value' do
    visit '/'

    assert_text 'Cardano 5,678.1235 $1.34 -4.359% $7,608.69'
    assert_text 'Cosmos 78.54321 $24.36 3.273% $1,913.31'

    assert_text 'Current portfolio value: $9,522.00'
  end
end

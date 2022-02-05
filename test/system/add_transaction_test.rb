# frozen_string_literal: true

require 'application_system_test_case'

class AddTransactionTest < ApplicationSystemTestCase
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

    Coin.create!(coins)
    User.create!
  end

  test 'add transaction for new issue' do
    visit '/'
    select 'Cardano', from: 'Coin'
    click_on 'Add new'
    fill_in 'Amount', with: '234.567'
    click_on 'Add Transaction'

    assert_text 'Cardano 234.567'

    select 'Cardano', from: 'Coin'
    click_on 'Add new'
    fill_in 'Amount', with: '56.89'
    click_on 'Add Transaction'

    assert_text 'Cardano 291.457'
  end
end

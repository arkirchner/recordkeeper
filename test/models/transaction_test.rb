# frozen_string_literal: true

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  setup do
    coin = Coin.create!(id: 'cardano', symbol: 'ada', name: 'Cardano')
    @asset = Asset.create!(coin: coin, user: User.create!)
  end

  test 'adds transactions amount to the assets total amount' do
    assert_changes '@asset.amount', from: 0, to: 123.456 do
      Transaction.create!(asset: @asset, amount: 123.456)
    end

    assert_changes '@asset.amount', from: 123.456, to: 0 do
      Transaction.create!(asset: @asset, amount: -123.456)
    end
  end

  test 'can not have greater amount then asset amount' do
    Transaction.create!(asset: @asset, amount: 10)

    transaction = Transaction.new(asset: @asset, amount: -10.0001)

    assert transaction.invalid?
  end
end

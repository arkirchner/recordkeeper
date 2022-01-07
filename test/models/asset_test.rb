# frozen_string_literal: true

require 'test_helper'

class AssetTest < ActiveSupport::TestCase
  setup do
    @user = User.create!
    @coin = Coin.create!(id: 'cardano', symbol: 'ada', name: 'Cardano')
  end

  test 'A user can only have one asset per coin.' do
    Asset.create!(user: @user, coin: @coin)

    assert Asset.new(user: @user, coin: @coin).invalid?
    assert Asset.new(user: User.create!, coin: @coin).valid?
  end
end

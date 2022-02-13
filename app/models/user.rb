# frozen_string_literal: true

class User < ApplicationRecord
  has_many :assets, dependent: :destroy

  def current_balance
    assets.inject(0) do |total, asset|
      total + asset.amount * (asset.coin.current_price.value || 0)
    end
  end
end

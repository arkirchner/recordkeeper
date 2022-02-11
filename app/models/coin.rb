# frozen_string_literal: true

class Coin < ApplicationRecord
  kredis_float :current_price
  kredis_float :twenty_four_hours_change

  def self.import(id)
    create!(Coingecko::Coin.new(id).load_coin.slice('id', 'name', 'symbol'))
  end

  def self.update_ohlc
    find_each do |coin|
      OhlcImportJob.perform_later(coin)
    end
  end

  def self.set_current_values
    coins = all.load
    current_values = Coingecko::CurrentPrice.new(coins.map(&:id)).load

    coins.each do |coin|
      coin.current_price.value = current_values[coin.id]['usd']
      coin.twenty_four_hours_change.value = current_values[coin.id]['usd_24h_change']
    end
  end
end

# frozen_string_literal: true

class Coin < ApplicationRecord
  def self.import(id)
    create!(Coingecko::Coin.new(id).load_coin.slice('id', 'name', 'symbol'))
  end

  def self.update_ohlc
    find_each do |coin|
      OhlcImportJob.perform_later(coin)
    end
  end
end

# frozen_string_literal: true

class Coin < ApplicationRecord
  def self.import
    client = CoingeckoRuby::Client.new

    upsert_all(client.coins_list)
  end
end

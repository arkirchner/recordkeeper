# frozen_string_literal: true

class OhlcImportJob < ApplicationJob
  queue_as :default

  def perform(coin)
    params = Coingecko::Coin.new(coin.id).load_ohlc
                            .select { |p| p[:recorded_at] < Time.current }

    Ohlc.upsert_all(params)
  end
end

# frozen_string_literal: true

class OhlcImportJob < ApplicationJob
  retry_on Coingecko::Coin::FreeTierLimitReached, wait: 61.seconds, attempts: 50, jitter: false
  queue_as :default

  def perform(coin)
    params = Coingecko::Coin.new(coin.id).load_ohlc
                            .select { |p| p[:recorded_at] < Time.current }

    Ohlc.upsert_all(params)
  end
end

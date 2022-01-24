# frozen_string_literal: true

module Coingecko
  BASE_URL = 'https://api.coingecko.com/api/v3/'
  SOURCE_NAME = 'coingecko'

  class Coin
    def initialize(id)
      @id = id
    end

    def load_ohlc
      response = Net::HTTP.get(ohlc_uri)

      parse_ohlc(JSON.parse(response)).map do |params|
        params.merge(coin_id: id, source: SOURCE_NAME)
      end
    end

    private

    def parse_ohlc(params)
      params.map do |date, open, high, low, close|
        {
          recorded_at: Time.zone.at(0, date, :millisecond),
          open: open,
          high: high,
          low: low,
          close: close
        }
      end
    end

    def ohlc_uri
      URI("#{BASE_URL}coins/#{id}/ohlc?vs_currency=usd&days=1")
    end

    attr_reader :id
  end
end

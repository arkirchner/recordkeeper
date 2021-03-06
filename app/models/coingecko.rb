# frozen_string_literal: true

module Coingecko
  BASE_URL = 'https://api.coingecko.com/api/v3/'
  SOURCE_NAME = 'coingecko'

  class FreeTierLimitReached < StandardError; end

  class CurrentPrice
    def initialize(coin_ids)
      @coin_ids = coin_ids
    end

    def load
      response = Net::HTTP.get_response(uri)

      case response
      when Net::HTTPSuccess
        JSON.parse(response.body)
      when Net::HTTPTooManyRequests
        raise FreeTierLimitReached
      else
        raise "Coingecko response error: #{response}"
      end
    end

    private

    def uri
      URI("#{BASE_URL}simple/price?ids=#{coin_ids.join(',')}&vs_currencies=usd&include_24hr_change=true")
    end

    attr_reader :coin_ids
  end

  class Coin
    def initialize(id)
      @id = id
    end

    def load_coin
      JSON.parse(Net::HTTP.get(coin_uri))
    end

    def load_ohlc
      case response
      when Net::HTTPSuccess
        parse_ohlc(JSON.parse(response.body)).map do |params|
          params.merge(coin_id: id, source: SOURCE_NAME)
        end
      when Net::HTTPTooManyRequests
        raise FreeTierLimitReached
      else
        raise "Coingecko response error: #{response}"
      end
    end

    private

    def response
      @response ||= Net::HTTP.get_response(ohlc_uri)
    end

    def parse_ohlc(params)
      params.map do |date, open, high, low, close|
        {
          recorded_at: Time.zone.at(0, date, :millisecond),
          open:,
          high:,
          low:,
          close:
        }
      end
    end

    def ohlc_uri
      URI("#{BASE_URL}coins/#{id}/ohlc?vs_currency=usd&days=1")
    end

    def coin_uri
      URI("#{BASE_URL}coins/#{id}")
    end

    attr_reader :id
  end
end

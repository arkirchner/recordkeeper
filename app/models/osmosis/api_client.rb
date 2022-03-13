# frozen_string_literal: true

module Osmosis
  class ApiClient
    BASE_URL = 'https://api-osmosis-chain.imperator.co'
    CLIENT = Faraday.new(url: BASE_URL) do |builder|
      builder.use Faraday::Response::RaiseError
      builder.response :json
      builder.adapter Faraday.default_adapter
    end

    def get_transactions(address:, limit: 15, offset: 0)
      CLIENT.get("/txs/v1/tx/address/#{address}", limit:, offset:).body
    end
  end
end

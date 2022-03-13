# frozen_string_literal: true

module Osmosis
  class Wallet < ApplicationRecord
    self.primary_key = :address
    self.table_name  = :osmosis_wallets

    has_many :transactions, foreign_key: :address, primary_key: :wallet_address, class_name: 'Osmosis::Transaction'
  end
end

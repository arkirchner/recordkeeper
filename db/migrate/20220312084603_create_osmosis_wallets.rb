# frozen_string_literal: true

class CreateOsmosisWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :osmosis_wallets, id: false do |t|
      t.string :address, primary_key: true

      t.timestamps
    end

    add_column :osmosis_transactions, :wallet_address, :string, null: false
    add_foreign_key :osmosis_transactions, :osmosis_wallets, primary_key: :address, column: :wallet_address
  end
end

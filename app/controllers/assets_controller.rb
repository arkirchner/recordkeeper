# frozen_string_literal: true

class AssetsController < ApplicationController
  def index
    @new_asset = Asset.new
    @assets = Asset.where(user: current_user)
  end

  def create
    coin = Coin.find(params.require(:asset).require(:coin_id))

    redirect_to new_coin_transaction_path(coin)
  end
end

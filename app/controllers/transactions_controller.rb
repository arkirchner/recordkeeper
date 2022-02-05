# frozen_string_literal: true

class TransactionsController < ApplicationController
  def new
    @coin = Coin.find(params[:coin_id])
    @transaction = Transaction.new
  end

  def create
    asset = Asset.find_or_initialize_by(coin_id: params[:coin_id], user: current_user)
    transaction = Transaction.new(transaction_params.merge(asset:))

    if transaction.save
      redirect_to assets_path
    else
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount)
  end
end

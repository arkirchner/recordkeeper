# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :asset

  validates :amount, presence: true
  validate :asset_amount_can_not_be_negative

  after_save do
    asset.increment!(:amount, amount)
  end

  private

  def asset_amount_can_not_be_negative
    return if amount.blank? || (asset.amount + amount) >= 0

    errors.add :amount, 'can not subtract more than the amount of the asset.'
  end
end

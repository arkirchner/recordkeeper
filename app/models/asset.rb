# frozen_string_literal: true

class Asset < ApplicationRecord
  belongs_to :user
  belongs_to :coin
  has_many :transactions, dependent: :destroy

  validates :coin, uniqueness: { scope: :user_id }
end

# frozen_string_literal: true

class AssetsController < ApplicationController
  def index
    @assets = Asset.where(user: current_user)
  end
end

# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def current_user
    User.first
  end
end

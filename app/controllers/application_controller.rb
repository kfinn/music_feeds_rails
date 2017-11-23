# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :ensure_feeds_fresh!

  def ensure_feeds_fresh!
    Feed.each(&:ensure_fresh!)
  end
end

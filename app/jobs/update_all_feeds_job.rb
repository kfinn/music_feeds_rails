# frozen_string_literal: true

class UpdateAllFeedsJob < ApplicationJob
  queue_as :default

  def perform
    Feed.all.each do |feed|
      feed.delay.update!
    end
  end
end

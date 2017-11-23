# frozen_string_literal: true

require 'yaml'

class Feed
  attr_reader :id, :name, :url, :strategy

  def initialize(id:, name:, url:, strategy:)
    @id = id
    @name = name
    @url = url
    @strategy = strategy
  end

  class << self
    def find(id)
      by_id[id].tap do |feed|
        raise "Couldn't find Feed with 'id'=#{id}" unless feed.present?
      end
    end

    def all
      @all ||= YAML.load_file(Rails.root.join('config/feeds.yml')).map do |feed_attributes|
        new feed_attributes.symbolize_keys
      end
    end

    delegate :each, to: :all

    private

    def by_id
      @by_id ||= all.each_with_object({}) { |feed, by_id| by_id[feed.id] = feed }.with_indifferent_access
    end
  end

  def update_from_remote!
    remote_feed.recommendations.each do |feed_item|
      Song.find_or_create_by!(feed_item.song_query).tap do |song|
        song.recommendations.find_or_initialize_by(guid: feed_item.guid).update!(feed_item.to_recommendation_attributes)
      end
    end
  end

  def feed_updates
    FeedUpdate.where feed_id: id
  end

  def recommendations
    @recommendations ||= Recommendation.for_feed self
  end

  def ensure_fresh!
    feed_updates.create! unless last_updated_at.present? && last_updated_at > 6.hours.ago
  end

  def last_updated_at
    unless instance_variable_defined? :@last_updated_at
      @last_updated_at = feed_updates.maximum(:created_at)
    end
    @last_updated_at
  end

  private

  def remote_feed
    @remote_feed ||= strategy.constantize.new
  end
end

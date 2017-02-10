require 'yaml'

class Feed
  include ActiveModel::Model
  attr_accessor :id, :name, :url, :strategy

  def self.find(id)
    by_id[id].tap do |feed|
      raise "Couldn't find Feed with 'id'=#{id}" unless feed.present?
    end
  end

  def self.all
    @all ||= YAML.load_file(Rails.root.join('config/feeds.yml')).map { |feed_attributes| new feed_attributes }
  end

  def update!
    remote_feed.recommendations.each do |feed_item|
      Song.find_or_create_by!(feed_item.song_query).tap do |song|
        song.recommendations.find_or_initialize_by(guid: feed_item.guid).update!(feed_item.to_recommendation_attributes)
      end
    end
  end

  def recommendations
    @recommendations ||= Recommendation.for_feed self
  end

  private

  def self.by_id
    @by_id ||= all.each_with_object({}) { |feed, by_id| by_id[feed.id] = feed }.with_indifferent_access
  end

  def remote_feed
    @remote_feed ||= self.strategy.constantize.new
  end
end

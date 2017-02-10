require 'yaml'

class Feed
  include ActiveModel::Model
  attr_accessor :id, :name, :url

  def self.find(id)
    by_id[id].tap do |feed|
      raise "Couldn't find Feed with 'id'=#{id}" unless feed.present?
    end
  end

  def self.by_id
    @by_id ||= all.each_with_object({}) { |feed, by_id| by_id[feed.id] = feed }.with_indifferent_access
  end

  def self.all
    @all ||= YAML.load_file(Rails.root.join('config/feeds.yml')).map { |feed_attributes| new feed_attributes }
  end
end

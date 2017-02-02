class Recommendation < ApplicationRecord
  belongs_to :song

  validates :guid, :url, :creator, null: false

  def as_json(*)
    {
      id: id,
      guid: guid,
      url: url,
      creator: creator,
      description: description,
      recommended_at: recommended_at
    }
  end
end

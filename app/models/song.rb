class Song < ActiveRecord::Base
  belongs_to :artist

  has_many :records
  has_many :weeks, through: :records
  has_many :charts, through: :records
  validates_uniqueness_of :name, scope: :artist_id
end

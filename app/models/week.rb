class Week < ActiveRecord::Base
  has_many :records
  has_many :songs, through: :records
  has_many :charts, through: :records
  belongs_to :year
  validates_uniqueness_of :number, scope: :year_id
end

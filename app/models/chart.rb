class Chart < ActiveRecord::Base
  belongs_to :country
  has_many :records
  has_many :weeks, through: :records
  has_many :songs, through: :records
end

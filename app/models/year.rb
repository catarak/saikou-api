class Year < ActiveRecord::Base
  has_many :weeks
  validates_uniqueness_of :number
end

class Record < ActiveRecord::Base
  belongs_to :chart
  belongs_to :week
  belongs_to :song
  validates_uniqueness_of :song_id, scope: [:chart_id, :week_id]
end

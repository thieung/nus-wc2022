class Score < ActiveRecord::Base
  scope :available, -> (ids) {where.not(id: ids)}
end
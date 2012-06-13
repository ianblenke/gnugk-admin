class Gksection < ActiveRecord::Base
  has_many :gkconfigs
  validates_uniqueness_of :name, :allow_blank => false, :allow_nil => false
  validates_presence_of :name
  scope :ordered_by_name, order("name asc")
end

class Staff < ActiveRecord::Base
  has_many :educations, :dependent => :destroy 
  accepts_nested_attributes_for :educations, :allow_destroy => true
end

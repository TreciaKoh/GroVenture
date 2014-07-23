class Staff < ActiveRecord::Base
  has_many :educations, :dependent => :destroy 
  accepts_nested_attributes_for :educations, :allow_destroy => true, :reject_if => lambda { |b| b[:schoolname].blank? }
  has_many :employment_histories, :dependent => :destroy 
  accepts_nested_attributes_for :employment_histories, :allow_destroy => true, :reject_if => lambda { |b| b[:employername].blank? }
end

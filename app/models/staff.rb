class Staff < ActiveRecord::Base
  has_many :educations, :dependent => :destroy 
  accepts_nested_attributes_for :educations, :allow_destroy => true, :reject_if => lambda { |b| b[:schoolname].blank? }
  has_many :employment_histories, :dependent => :destroy 
  accepts_nested_attributes_for :employment_histories, :allow_destroy => true, :reject_if => lambda { |b| b[:employername].blank? }
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  has_attached_file :icfront, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :icfront, :content_type => /\Aimage\/.*\Z/
  has_attached_file :icback, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :icback, :content_type => /\Aimage\/.*\Z/
  has_attached_file :childbirthcert, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :childbirthcert, :content_type => /\Aimage\/.*\Z/
end

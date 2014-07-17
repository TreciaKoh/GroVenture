class Logo < ActiveRecord::Base
  has_attached_file :supportdoc, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  #validates_attachment_content_type :attachment, :content_type => ['application/msword', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document']
  validates_attachment_presence :supportdoc
end

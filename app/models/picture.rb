class Picture
  include DataMapper::Resource
  include Paperclip::Resource
  
  property :id, Serial

  has_attached_file :image,
    :default_url => "/uploads/pictures/:attachment/missing_:style.png",
    :url => "/uploads/pictures/:id/:style/:basename.:extension",
    :path => ":merb_root/public/uploads/pictures/:id/:style/:basename.:extension",
    :styles => {:small => "55x55#", :medium => "100x100#", :large => "600x600>" }

end

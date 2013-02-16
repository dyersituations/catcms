class Page < ActiveRecord::Base
  attr_accessible :content, :path, :title, :page_type

  PAGETYPES = { :PLAIN => 1, :GALLERY => 2, :BLOG => 3 }
end

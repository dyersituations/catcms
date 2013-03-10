class Page < ActiveRecord::Base
  attr_accessible :content, :path, :title, :page_type

  PAGETYPES = { :HOME => 0, :PLAIN => 1, :GALLERY => 2, :BLOG => 3 }
end

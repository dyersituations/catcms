class Page < ActiveRecord::Base
  attr_accessible :page_type, :path, :title, :header, :content

  PAGETYPES = { :HOME => 0, :PLAIN => 1, :GALLERY => 2, :BLOG => 3 }
end

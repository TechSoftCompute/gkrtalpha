class Page < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :title , :url , :description,:cost,:image_src,:category
  validates :title,:presence => true
  validates :image_src,:presence => true
 # validates :url, :presence => true, :uri => { :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix }
 
end

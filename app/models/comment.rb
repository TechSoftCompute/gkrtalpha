class Comment < ActiveRecord::Base
  attr_accessible :body, :creator_id, :product_id
  belongs_to :product
  belongs_to :creator,:class_name=>"User"
end

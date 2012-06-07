class Product < ActiveRecord::Base
  attr_accessible :name, :price,:image ,:remote_image_url,:creator_id,:description,:category_id
  mount_uploader :image,ImageUploader

  belongs_to :creator,:class_name=>"User"
  belongs_to :category
  has_many :comments

	validates :price, :numericality => {:message=>"Please Enter Numerical value"}
  validates :name,:price,:category_id,presence: true

	def liked_percentage
		like,dislike = self.liked.to_i , self.disliked.to_i
		percentage =  like + dislike == 0 ? 0 : (like.to_f / (like.to_f + dislike.to_f)) * 100
		"#{percentage.round(2)}%"
	end

	def self.few_products(options={})
		if options[:order] == 'lowest_price'
			find(:all,:order=>"price ASC",:limit=>8,:offset=> options[:offset] * 8)
		elsif options[:order] == 'highest_price'
			find(:all,:order=>"price DESC",:limit=>8,:offset=> options[:offset] * 8)
		else
			find(:all,:order=>"#{options[:order] || 'created_at'} DESC",:limit=>8,:offset=> options[:offset] * 8)
		end
	end

end

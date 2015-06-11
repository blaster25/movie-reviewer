class Movie < ActiveRecord::Base
	#for seach elasticsearch
	searchkick word_start: [:title, :director]

	validates :title, presence: true, length: { minimum: 5, maximum: 50 }
	validates :description, presence: true
	validates :director, presence: true
	# validates :duration, presence: true, numericality: true
	validates :duration, presence: true, format: { with: /\A\d{1,2}:\d{1,2}\Z/, message: ":only time ralated expressions can be used !!" }
	
	belongs_to :user
	has_many :reviews

	has_attached_file :image, :styles => { small: "150x150>", :medium => "300x300>", :thumb => "100x100>" }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

    def image_url
    	image.url
    end
end

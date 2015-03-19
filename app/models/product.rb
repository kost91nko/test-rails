class Product < ActiveRecord::Base
  validates_presence_of :name
  validates_length_of :name, :minimum => 3
  belongs_to :factory
end

class Blog < ApplicationRecord
  validates :title, :presence => true
  validates :body, :presence => true

  belongs_to :user

  def self.whitelisted_attributes
    [:title, :body, :body]
  end
end
  

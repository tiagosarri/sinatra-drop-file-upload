# encoding: utf-8

require 'mongoid'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :email, :type => String, :null => false
  
  has_many :photos
  
  validates_presence_of :email
  validates_uniqueness_of :email
  
  def self.get_or_create email
    user = User.find(:first, conditions: { email: email })
    
    if (user == nil)
      User.create! :email => email
    else
      user  
    end    
  end
                        
end
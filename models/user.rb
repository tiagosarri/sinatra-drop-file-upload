# encoding: utf-8

require 'mongoid'

class User
  include Mongoid::Document
  
  field :email, :type => String, :null => false
  field :created_at, :type => DateTime, :null => false
  
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
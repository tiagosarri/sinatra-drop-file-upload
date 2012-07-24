# encoding: utf-8

require 'mongoid'

class User
  include Mongoid::Document
  
  field :title, :type => String, :null => false
  field :created_at, :type => DateTime, :null => false
  
  validates_presence_of :title
  
  def self.create_message description
    User.create! :title => description, :created_at => DateTime.now
  end
                        
end
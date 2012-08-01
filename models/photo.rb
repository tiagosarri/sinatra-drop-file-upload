# encoding: utf-8

require 'mongoid'
require './uploaders/avatar_uploader'

class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  
  #attr_accessible :avatar, :remote_avatar_url, :avatar_cache, :remove_avatar
  
  mount_uploader :avatar, AvatarUploader
  
  belongs_to :user
  
end
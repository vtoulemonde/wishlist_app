class Item < ActiveRecord::Base
  belongs_to :list
  mount_uploader :picture, PictureUploader
end

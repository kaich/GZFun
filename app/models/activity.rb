class Activity < ApplicationRecord
  
  belongs_to :user

  acts_as_votable
  acts_as_commentable

  mount_uploader :cover, AvatarUploader

end

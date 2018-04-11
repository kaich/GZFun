class Activity < ApplicationRecord

  mount_uploader :cover, ActivityCoverUploader

  acts_as_votable
  acts_as_commentable

end

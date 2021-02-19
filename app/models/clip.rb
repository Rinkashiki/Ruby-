class Clip < ApplicationRecord

  mount_uploader :video, VideoUploader, presence: true

  belongs_to :decision, optional: true

  belongs_to :sanction, optional: true

  has_and_belongs_to_many :topics
   
end

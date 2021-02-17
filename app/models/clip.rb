class Clip < ApplicationRecord

  mount_uploader :video, VideoUploader

  has_one :decision

  has_one :sanction
   
end

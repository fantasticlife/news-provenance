class ExtractedEntity < ActiveRecord::Base
  
  belongs_to :article
  belongs_to :entity
end

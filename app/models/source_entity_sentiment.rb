class SourceEntitySentiment < ActiveRecord::Base
  
  belongs_to :source
  belongs_to :entity
end

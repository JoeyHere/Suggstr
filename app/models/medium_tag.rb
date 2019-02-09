class MediumTag < ActiveRecord::Base
  belongs_to :medium
  belongs_to :tag
end

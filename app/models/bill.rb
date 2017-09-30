class Bill < ActiveRecord::Base
  # include Meta

  belongs_to :household
end

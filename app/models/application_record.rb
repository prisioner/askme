class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  TAG_REGEX = /#[[:word:]-]+/
end

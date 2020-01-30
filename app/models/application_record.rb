class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.random
    order('random()').limit(1).first
  end
end

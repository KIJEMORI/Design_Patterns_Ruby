class Recipe < ApplicationRecord
  belongs_to :doctor
  belongs_to :medicine
end

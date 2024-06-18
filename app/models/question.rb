class Question < ApplicationRecord
  belongs_to :subject
  has_many :answers
  accepts_nested_attributes_for :answers
  # Kaminari
  paginates_per 7
end

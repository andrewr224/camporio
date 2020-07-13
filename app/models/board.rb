# frozen_string_literal: true

class Board < ApplicationRecord
  validates :name, presence: true, length: { minimum: 4, maximum: 280 }
  validates :description, length: { maximum: 550 }
end

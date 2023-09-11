# frozen_string_literal: true

class LearningPathTalent < ApplicationRecord
  belongs_to :learning_path, inverse_of: :learning_path_talents
  belongs_to :talent, class_name: 'User', inverse_of: :learning_path_talents

  validates :learning_path, uniqueness: { scope: :talent }
end

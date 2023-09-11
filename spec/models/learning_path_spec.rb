# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LearningPath, type: :model do
  subject { build(:learning_path) }

  it { should have_many(:learning_path_talents).dependent(:destroy) }
  it { should have_many(:talents).through(:learning_path_talents) }

  it { should have_many(:learning_path_courses).dependent(:destroy) }
  it { should have_many(:courses).through(:learning_path_courses) }

  it { should validate_presence_of(:name) }

  it { should be_valid }
end

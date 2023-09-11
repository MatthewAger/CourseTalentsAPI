# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  subject { build(:course) }

  it { should belong_to(:author) }

  it { should have_many(:course_talents).dependent(:destroy) }
  it { should have_many(:talents).through(:course_talents) }

  it { should have_many(:learning_path_courses).dependent(:destroy) }
  it { should have_many(:learning_paths).through(:learning_path_courses) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  it { should be_valid }
end

# frozen_string_literal: true

FactoryBot.define do
  factory :learning_path_course do
    learning_path { build(:learning_path) }
    course        { build(:course) }

    sequence(:position) { |n| n }
  end
end

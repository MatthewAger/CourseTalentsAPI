# frozen_string_literal: true

FactoryBot.define do
  factory :learning_path do
    name { 'MyString' }
  end

  trait :with_courses do
    after(:build) do |learning_path|
      build_list(:learning_path_course, 3, learning_path:)
    end
  end
end

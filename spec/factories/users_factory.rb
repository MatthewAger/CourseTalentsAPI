# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'MyString' }

    trait :with_authored_courses do
      after(:build) do |user|
        build_list(:course, 3, author: user)
      end
    end

    trait :with_courses do
      after(:build) do |user|
        build_list(:course_talent, 3, talent: user)
      end
    end

    trait :with_learning_paths do
      after(:build) do |user|
        build_list(:learning_path_talent, 3, talent: user)
      end
    end
  end
end

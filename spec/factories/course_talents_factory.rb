# frozen_string_literal: true

FactoryBot.define do
  factory :course_talent do
    course { build(:course) }
    talent { build(:user) }

    completed_at { nil }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :learning_path_talent do
    learning_path { build(:learning_path) }
    talent        { build(:user) }

    completed { false }
  end
end

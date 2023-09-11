# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    author { build(:user) }

    title       { 'MyString' }
    description { 'MyText' }
  end
end

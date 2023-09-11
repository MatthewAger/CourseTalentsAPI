# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { should have_many(:authored_courses) }

  it { should have_many(:course_talents).dependent(:destroy) }
  it { should have_many(:courses).through(:course_talents) }

  it { should have_many(:learning_path_talents).dependent(:destroy) }
  it { should have_many(:learning_paths).through(:learning_path_talents) }

  it { should validate_presence_of(:name) }

  it { should be_valid }

  describe '#author?' do
    context 'when user has no authored courses' do
      it 'returns false' do
        expect(subject.author?).to be(false)
      end
    end

    context 'when user has authored courses' do
      let(:user) { build(:user, :with_authored_courses) }

      it 'returns true' do
        expect(user.author?).to be(true)
      end
    end
  end

  describe '#talent?' do
    context 'when user has no courses or learning paths' do
      it 'returns false' do
        expect(subject.talent?).to be(false)
      end
    end

    context 'when user has courses' do
      let(:user) { build(:user, :with_courses) }

      it 'returns true' do
        expect(user.talent?).to be(true)
      end
    end

    context 'when user has learning paths' do
      let(:user) { build(:user, :with_learning_paths) }

      it 'returns true' do
        expect(user.talent?).to be(true)
      end
    end
  end
end

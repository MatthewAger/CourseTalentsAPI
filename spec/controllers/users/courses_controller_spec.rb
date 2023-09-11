# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::CoursesController, type: :controller do
  describe '#update' do
    let!(:user) { create(:user, name: 'Joe') }
    let!(:course) { create(:course, title: 'Course 1') }

    context 'for a standalone course' do
      before do
        create(:course_talent, course:, talent: user)
      end

      it 'returns a success message' do
        put :update, params: { user_id: user.id, id: course.id }, as: :json
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json['success']).to eq(true)
        expect(json['messages']).to eq('Course 1 completed by Joe!')
      end
    end

    context 'when the course is part of a learning path' do
      let!(:learning_path) { create(:learning_path, name: 'Learning path 1') }
      let!(:second_course) { create(:course, title: 'Course 2') }
      let!(:third_course)  { create(:course, title: 'Course 3') }
      let!(:course_talent) { create(:course_talent, course:, talent: user) }
      let!(:learning_path_talent) { create(:learning_path_talent, learning_path:, talent: user) }

      before do
        create(:learning_path_course, learning_path:, course:, position: 1)
        create(:learning_path_course, learning_path:, course: second_course, position: 2)
        create(:learning_path_course, learning_path:, course: third_course, position: 3)
      end

      it 'returns a success message' do
        expect { put :update, params: { user_id: user.id, id: course.id }, as: :json }.to \
          change(CourseTalent, :count).by(1)
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json['success']).to eq(true)
        expect(json['messages']).to eq('Course 1 completed by Joe!')

        expect(learning_path_talent.reload.completed_at).not_to be_present
        expect(course_talent.reload.completed_at).to be_present

        second_course_talent = CourseTalent.find_by(course: second_course, talent: user)
        expect(second_course_talent).to be_present
        expect(second_course_talent.completed_at).to be_nil

        put :update, params: { user_id: user.id, id: course.id }, as: :json
        expect(response.status).to eq(422)

        json = response.parsed_body
        expect(json['success']).to eq(false)
        expect(json['messages']).to eq(["Completed at #{course_talent.completed_at.strftime('%d/%m/%y')}"])

        expect { put :update, params: { user_id: user.id, id: second_course.id }, as: :json }.to \
          change(CourseTalent, :count).by(1)
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json['success']).to eq(true)
        expect(json['messages']).to eq('Course 2 completed by Joe!')

        expect(learning_path_talent.reload.completed_at).not_to be_present
        expect(second_course_talent.reload.completed_at).to be_present

        third_course_talent = CourseTalent.find_by(course: third_course, talent: user)
        expect(third_course_talent).to be_present
        expect(third_course_talent.completed_at).to be_nil

        expect(CourseTalent.all.count).to eq(3)
        put :update, params: { user_id: user.id, id: third_course.id }, as: :json
        expect(CourseTalent.all.count).to eq(3)
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json['success']).to eq(true)
        expect(json['messages']).to eq('Course 3 completed by Joe!')
        expect(learning_path_talent.reload.completed_at).to be_present
      end
    end
  end
end

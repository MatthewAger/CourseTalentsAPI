# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe '#index' do
    context 'when there are no existing courses' do
      it 'returns an empty list' do
        get :index, as: :json
        expect(response.status).to eq(200)
        expect(response.body).to eq([].to_json)
      end
    end

    context 'when there are existing courses' do
      let!(:courses) { create_list(:course, 3) }

      it 'returns a list of courses' do
        get :index, as: :json
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json.size).to eq(3)
        expect(json.first.keys).to eq(%w[id title description created_at updated_at author url])
      end
    end
  end

  describe '#show' do
    let!(:course) { create(:course) }

    it 'returns a course' do
      get :show, params: { id: course.id }, as: :json
      expect(response.status).to eq(200)

      json = response.parsed_body
      expect(json['author']['id']).to eq(course.author.id)
      expect(json['title']).to eq('MyString')
      expect(json['description']).to eq('MyText')
      expect(json['url']).to eq("http://test.host/api/courses/#{course.id}.json")
    end
  end

  describe '#create' do
    let!(:author) { create(:user) }

    context 'when the request is valid' do
      let(:course_params) { { author_id: author.id, title: 'MyString', description: 'MyText' } }

      it 'creates a course' do
        expect { post :create, params: course_params, as: :json }.to change(Course, :count).by(1)
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json['author']['id']).to eq(author.id)
        expect(json['title']).to eq('MyString')
        expect(json['description']).to eq('MyText')
      end
    end

    context 'when the request is invalid' do
      let(:course_params) { { title: nil, description: nil } }

      it 'returns an error' do
        post :create, params: course_params, as: :json
        expect(response.status).to eq(422)
        error = { success: false, messages: ['Author must exist', "Title can't be blank", "Description can't be blank"] }
        expect(response.body).to eq(error.to_json)
      end
    end

    context 'when the author is also a talent' do
      let!(:talent) { create(:user, :with_courses) }
      let(:course_params) { { author_id: talent.id, title: 'MyString', description: 'MyText' } }

      it 'creates a course but the author cannot also be a talent' do
        expect { post :create, params: course_params, as: :json }.to change(Course, :count).by(1)
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json['author']['id']).to eq(talent.id)

        course = Course.find(json['id'])
        course_talent = build(:course_talent, course:, talent:)
        expect(course_talent).not_to be_valid
      end
    end
  end

  describe '#update' do
    let!(:course) { create(:course) }

    context 'when the request is valid' do
      let(:course_params) { { title: 'MyString', description: 'MyText' } }

      it 'updates a course' do
        put :update, params: { id: course.id }.merge(course_params), as: :json
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json['author']['id']).to eq(course.author_id)
        expect(json['title']).to eq('MyString')
        expect(json['description']).to eq('MyText')
      end
    end

    context 'when the request is invalid' do
      let(:course_params) { { title: nil, description: nil } }

      it 'returns an error' do
        put :update, params: { id: course.id }.merge(course_params), as: :json
        expect(response.status).to eq(422)
        error = { success: false, messages: ["Title can't be blank", "Description can't be blank"] }
        expect(response.body).to eq(error.to_json)
      end
    end
  end

  describe '#destroy' do
    let!(:course) { create(:course) }

    it 'deletes a course' do
      expect { delete :destroy, params: { id: course.id }, as: :json }.to change(Course, :count).by(-1)
      expect(response.status).to eq(204)
    end
  end
end

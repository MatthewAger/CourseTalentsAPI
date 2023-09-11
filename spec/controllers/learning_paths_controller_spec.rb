# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LearningPathsController, type: :controller do
  describe '#index' do
    context 'when there are no existing learning_paths' do
      it 'returns an empty list' do
        get :index, as: :json
        expect(response.status).to eq(200)
        expect(response.body).to eq([].to_json)
      end
    end

    context 'when there are existing learning_paths' do
      let!(:learning_paths) { create_list(:learning_path, 3) }

      it 'returns a list of learning_paths' do
        get :index, as: :json
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json.size).to eq(3)
        expect(json.first.keys).to eq(%w[id name created_at updated_at url courses])
      end
    end
  end

  describe '#show' do
    let!(:learning_path) { create(:learning_path) }

    it 'returns a learning_path' do
      get :show, params: { id: learning_path.id }, as: :json
      expect(response.status).to eq(200)

      json = response.parsed_body
      expect(json['name']).to eq('MyString')
      expect(json['url']).to eq("http://test.host/api/learning_paths/#{learning_path.id}.json")
    end

    context 'when the learning_path has courses' do
      let!(:learning_path) { create(:learning_path, :with_courses) }

      it 'returns a learning_path with courses' do
        get :show, params: { id: learning_path.id }, as: :json
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json['courses']).to be_a(Array)
        expect(json['courses'].size).to eq(3)
        expect(json['courses'].first.keys).to eq(%w[id title description created_at updated_at author url])
      end
    end
  end

  describe '#create' do
    context 'when the request is valid' do
      let(:learning_path_params) { { name: 'MyString' } }

      it 'creates a learning_path' do
        expect { post :create, params: learning_path_params, as: :json }.to change(LearningPath, :count).by(1)
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json['name']).to eq('MyString')
      end
    end

    context 'when the request is invalid' do
      let(:learning_path_params) { { name: nil } }

      it 'returns an error' do
        post :create, params: learning_path_params, as: :json
        expect(response.status).to eq(422)
        expect(response.body).to eq({ success: false, errors: ["Name can't be blank"] }.to_json)
      end
    end
  end

  describe '#update' do
    let!(:learning_path) { create(:learning_path) }

    context 'when the request is valid' do
      let(:learning_path_params) { { name: 'John' } }

      it 'updates a learning_path' do
        put :update, params: { id: learning_path.id }.merge(learning_path_params), as: :json
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json['name']).to eq('John')
      end
    end

    context 'when the request is invalid' do
      let(:learning_path_params) { { name: nil } }

      it 'returns an error' do
        put :update, params: { id: learning_path.id }.merge(learning_path_params), as: :json
        expect(response.status).to eq(422)
        expect(response.body).to eq({ success: false, errors: ["Name can't be blank"] }.to_json)
      end
    end
  end

  describe '#destroy' do
    let!(:learning_path) { create(:learning_path) }

    it 'deletes a learning_path' do
      expect { delete :destroy, params: { id: learning_path.id }, as: :json }.to change(LearningPath, :count).by(-1)
      expect(response.status).to eq(204)
    end
  end
end

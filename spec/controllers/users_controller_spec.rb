# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#index' do
    context 'when there are no existing users' do
      it 'returns an empty list' do
        get :index, as: :json
        expect(response.status).to eq(200)
        expect(response.body).to eq([].to_json)
      end
    end

    context 'when there are existing users' do
      let!(:users) { create_list(:user, 3) }

      it 'returns a list of users' do
        get :index, as: :json
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json.size).to eq(3)
        expect(json.first.keys).to eq(%w[id name author? talent? created_at updated_at url courses learning_paths])
      end
    end
  end

  describe '#show' do
    let!(:user) { create(:user) }

    it 'returns a user' do
      get :show, params: { id: user.id }, as: :json
      expect(response.status).to eq(200)

      json = response.parsed_body
      expect(json['name']).to eq('MyString')
      expect(json['author?']).to eq(false)
      expect(json['talent?']).to eq(false)
      expect(json['url']).to eq("http://test.host/api/users/#{user.id}.json")
      expect(json['courses']).to be_a(Hash)
      expect(json['courses'].keys).to eq(%w[author talent])
      expect(json['learning_paths']).to eq([])
    end

    context 'when the user is an author of courses' do
      let!(:user) { create(:user, :with_authored_courses) }

      it 'returns a user with courses' do
        get :show, params: { id: user.id }, as: :json
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json['author?']).to eq(true)
        expect(json.dig('courses', 'author').size).to eq(3)
        expect(json.dig('courses', 'author').first.keys).to \
          eq(%w[id title description created_at updated_at author url])
      end
    end

    context 'when the user is a talent of courses' do
      let!(:user) { create(:user, :with_courses) }

      it 'returns a user with courses' do
        get :show, params: { id: user.id }, as: :json
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json['talent?']).to eq(true)
        expect(json.dig('courses', 'talent').size).to eq(3)
        expect(json.dig('courses', 'talent').first.keys).to \
          eq(%w[id title description created_at updated_at author url])
      end
    end

    context 'when the user is a talent of learning paths' do
      let!(:user) { create(:user, :with_learning_paths) }

      it 'returns a user with learning paths' do
        get :show, params: { id: user.id }, as: :json
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json['talent?']).to eq(true)
        expect(json['learning_paths'].size).to eq(3)
        expect(json['learning_paths'].first.keys).to \
          eq(%w[id name created_at updated_at url courses])
      end
    end
  end

  describe '#create' do
    context 'when the request is valid' do
      let(:user_params) { { name: 'MyString' } }

      it 'creates a user' do
        expect { post :create, params: user_params, as: :json }.to change(User, :count).by(1)
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json['name']).to eq('MyString')
      end
    end

    context 'when the request is invalid' do
      let(:user_params) { { name: nil } }

      it 'returns an error' do
        post :create, params: user_params, as: :json
        expect(response.status).to eq(422)
        expect(response.body).to eq({ success: false, errors: ["Name can't be blank"] }.to_json)
      end
    end
  end

  describe '#update' do
    let!(:user) { create(:user) }

    context 'when the request is valid' do
      let(:user_params) { { name: 'John' } }

      it 'updates a user' do
        put :update, params: { id: user.id }.merge(user_params), as: :json
        expect(response.status).to eq(200)

        json = response.parsed_body
        expect(json['name']).to eq('John')
      end
    end

    context 'when the request is invalid' do
      let(:user_params) { { name: nil } }

      it 'returns an error' do
        put :update, params: { id: user.id }.merge(user_params), as: :json
        expect(response.status).to eq(422)
        expect(response.body).to eq({ success: false, errors: ["Name can't be blank"] }.to_json)
      end
    end
  end

  describe '#destroy' do
    let!(:user) { create(:user) }

    it 'deletes a user' do
      expect { delete :destroy, params: { id: user.id }, as: :json }.to change(User, :count).by(-1)
      expect(response.status).to eq(204)
    end
  end
end

require 'swagger_helper'

RSpec.describe 'api/v1/sessions', type: :request do
  path '/api/v1/login' do
    post('create session') do
      consumes 'multipart/form-data'
      produces 'application/json'
      tags :session

      parameter name: :username, type: :string, in: :formData, required: true, schema: {
        type: :object, minimum: 3, maximum: 50
      }

      parameter name: :password, in: :formData, type: :string, required: true, schema: {
        type: :object, minimum: 8
      }

      context 'when valid params' do
        let(:user) { create(:user, password: Helpers::UserAuthHelper::PASSWORD) }
        let(:username) { user.username }
        let(:password) { Helpers::UserAuthHelper::PASSWORD }

        response(201, 'created') do
          run_test! do
            expect(response.body).to match_response_schema(Api::Schemas::Session::MAIN)
          end
        end
      end

      context 'when invalid username' do
        let(:user) { create(:user, password: Helpers::UserAuthHelper::PASSWORD) }
        let(:username) { "#{user.username}s" }
        let(:password) { Helpers::UserAuthHelper::PASSWORD }

        response(401, 'unauthorized') do
          run_test!
        end
      end

      context 'when invalid password' do
        let(:user) { create(:user, password: Helpers::UserAuthHelper::PASSWORD) }
        let(:username) { user.username }
        let(:password) { 'invalid' }

        response(401, 'unauthorized') do
          run_test!
        end
      end
    end
  end

  path '/api/v1/logout' do
    delete('delete session') do
      tags :session

      response(200, 'successfull') do
        run_test!
      end
    end
  end
end

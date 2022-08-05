require 'swagger_helper'

RSpec.describe 'api/v1/sessions', type: :request do
  path '/api/v1/login' do
    post('create session') do
      consumes 'multipart/form-data'
      produces 'application/json'
      tags :session

      parameter name: :username, in: :formData, type: :string, required: true, example: 'Username', minimum: 3,
                maximum: 50
      parameter name: :password, in: :formData, type: :string, required: true, example: 'Password7', minimum: 8

      context 'when valid params' do
        let(:user) { create(:user, password: Helpers::UserAuthHelper::PASSWORD) }
        let(:username) { user.username }
        let(:password) { Helpers::UserAuthHelper::PASSWORD }

        response(201, 'created') do
          schema type: :object, '$ref': '#/definitions/session_response'

          run_test! do
            parsed_body = JSON.parse(response.body)
            expect(parsed_body['user']).to eq(username)
            expect(parsed_body['logged_in']).to be(true)
            expect(parsed_body['message']).to eq(I18n.t('authentication.success.logged_in'))
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
        run_test! do
          parsed_body = JSON.parse(response.body)
          expect(parsed_body['message']).to eq(I18n.t('authentication.success.logged_out'))
        end
      end
    end
  end
end

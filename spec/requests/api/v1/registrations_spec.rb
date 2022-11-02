require 'swagger_helper'

RSpec.describe 'api/v1/registrations' do
  path '/api/v1/signup' do
    post('create account') do
      consumes 'multipart/form-data'
      produces 'application/json'
      tags :registration

      parameter name: :username, in: :formData, type: :string, required: true, minimum: 3, maximum: 50
      parameter name: :password, in: :formData, type: :string, required: true, minimum: 8
      parameter name: :password_confirmation, in: :formData, type: :string, required: true, minimum: 8

      context 'when with valid params' do
        let(:username) { 'Username' }
        let(:password) { 'Password7' }
        let(:password_confirmation) { 'Password7' }

        response(201, 'successful') do
          schema type: :object, '$ref': '#/definitions/registration_response'

          run_test! do
            parsed_body = JSON.parse(response.body)
            expect(parsed_body['user']).to eq(username)
            expect(parsed_body['message']).to eq(I18n.t('authentication.success.sig_up'))
          end
        end
      end

      context 'when with invalid params' do
        let(:username) { 'Je' }
        let(:password) { 'Securepassword' }
        let(:password_confirmation) { nil }

        response(422, 'unprocessable_entity') do
          schema type: :object,
                 properties: {
                   errors: { type: :object }
                 }

          run_test!
        end
      end
    end
  end
end

require 'swagger_helper'

RSpec.describe 'api/v1/registrations', type: :request do
  path '/api/v1/registrations' do
    post('create registration') do
      consumes 'multipart/form-data'
      produces 'application/json'
      tags :registration

      parameter name: :username, in: :formData, type: :string, required: true
      parameter name: :password, in: :formData, type: :string, required: true
      parameter name: :password_confirmation, in: :formData, type: :string, required: true

      context 'when with valid params' do
        let(:username) { 'Jennyfer' }
        let(:password) { 'Securepassword' }
        let(:password_confirmation) { 'Securepassword' }

        response(201, 'successful') do
          schema type: :object, '$ref': '#/definitions/sign_up'

          run_test! do
            expect(response.body).to match_response_schema(Api::Schemas::Registration::MAIN)
          end
        end
      end

      context 'when with invalid params' do
        let(:username) { 'Je' }
        let(:password) { 'Securepassword' }
        let(:password_confirmation) { nil }

        response(422, 'unprocessable_entity') do
          run_test!
        end
      end
    end
  end
end

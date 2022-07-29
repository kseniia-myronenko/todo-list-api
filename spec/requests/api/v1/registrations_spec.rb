require 'swagger_helper'

RSpec.describe 'api/v1/registrations', type: :request do
  path '/api/v1/signup' do
    post('create account') do
      consumes 'multipart/form-data'
      produces 'application/json'
      tags :registration

      parameter name: :username, in: :formData, type: :string, required: true
      parameter name: :password, in: :formData, type: :string, required: true
      parameter name: :password_confirmation, in: :formData, type: :string, required: true

      context 'when with valid params' do
        let(:username) { 'Jennyfer' }
        let(:password) { Helpers::UserAuthHelper::PASSWORD }
        let(:password_confirmation) { Helpers::UserAuthHelper::PASSWORD }

        # response(201, 'successful') do
        #   schema type: :object, '$ref': '#/definitions/sign_up'

        #   run_test! do
        #     expect(response.body).to match_response_schema(Api::Schemas::Registration::MAIN)
        #   end
        # end
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

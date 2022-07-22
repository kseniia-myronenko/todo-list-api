require 'swagger_helper'

RSpec.describe 'projects', type: :request do
  path '/api/v1' do
    get('projects') do
      tags :projects
      produces 'application/json'
      security [basicAuth: []]

      context 'when authenticated' do
        before { authorized }

        response(200, 'successful') do
          run_test!
        end
      end

      context 'when is not authenticated' do
        before { not_authorized }

        response(401, 'unauthorized') do
          run_test!
        end
      end
    end
  end

  # describe 'POST /create' do
  #   it 'returns http success' do
  #     post api_v1_projects_path
  #     expect(response).to have_http_status(:created)
  #   end
  # end
end

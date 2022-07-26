require 'swagger_helper'

RSpec.describe 'projects', type: :request do
  let!(:user) { create(:user, password: Helpers::UserAuthHelper::PASSWORD) }

  path '/api/v1' do
    get('show projects') do
      tags :projects
      produces 'application/json'
      security [basicAuth: []]

      context 'when with zero projects' do
        before { authenticate(user) }

        response(200, 'successful') do
          schema anyOf: [{ '$ref': '#/definitions/all_projects' }, {}]

          run_test! do
            expect(response.body).to match_response_schema(Api::Schemas::Project::MANY_SCHEMA)
          end
        end
      end

      context 'when with projects' do
        let!(:projects) { create_list(:project, 3, user:) }

        before { authenticate(user) }

        response(200, 'successful') do
          schema anyOf: [{ '$ref': '#/definitions/all_projects' }, {}]

          run_test! do
            parsed_body = JSON.parse(response.body)

            expect(response.body).to match_response_schema(Api::Schemas::Project::MANY_SCHEMA)
            expect(parsed_body['data'].length).to eq 3
            expect(parsed_body['data'].first['id']).to eq(projects[0].id)
          end
        end
      end

      context 'when unauthorized' do
        response(401, 'unauthorized') do
          run_test!
        end
      end
    end
  end

  path '/api/v1/projects' do
    post('create new project') do
      consumes 'multipart/form-data'
      produces 'application/json'
      tags :projects

      security [basicAuth: []]
      parameter name: :name, in: :formData, type: :string, required: true

      context 'when valid params' do
        before { authenticate(user) }

        let(:name) { 'Project name' }

        response(201, 'created') do
          schema type: :object, '$ref': '#/definitions/single_project'

          run_test! do
            parsed_body = JSON.parse(response.body)

            expect(response.body).to match_response_schema(Api::Schemas::Project::SINGLE_SCHEMA)
            expect(parsed_body['data']['attributes']['name']).to eq('Project name')
          end
        end
      end

      context 'when empty name' do
        before { authenticate(user) }

        let(:name) { nil }

        response(422, 'unprocessable_entity') do
          schema type: :object,
                 properties: {
                   errors: { type: :object }
                 }

          run_test!
        end
      end

      context 'when duplicated name' do
        let(:project) { create(:project, user:) }
        let(:name) { project.name }

        before { authenticate(user) }

        response(422, 'unprocessable_entity') do
          schema type: :object,
                 properties: {
                   errors: { type: :object }
                 }

          run_test!
        end
      end

      context 'when unauthorized' do
        let(:name) { 'Home tasks' }

        response(401, 'unauthorized') do
          run_test!
        end
      end
    end
  end

  path '/api/v1/projects/{id}' do
    get('show project') do
      produces 'application/json'
      tags :projects

      security [basicAuth: []]
      parameter name: :id, in: :path, type: :string, description: 'id'

      context 'when authenticated' do
        before { authenticate(user) }

        response(200, 'successful') do
          let(:id) { create(:project, user:).id }

          schema type: :object, '$ref': '#/definitions/single_project'

          run_test! do
            parsed_body = JSON.parse(response.body)

            expect(parsed_body['data']['id']).to eq(id)
            expect(response.body).to match_response_schema(Api::Schemas::Project::SINGLE_SCHEMA)
          end
        end

        response(404, 'not_found') do
          let(:id) { create(:project, user: create(:user)).id }

          run_test!
        end
      end

      context 'when unauthorized' do
        let(:id) { create(:project, user:).id }

        response(401, 'unauthorized') do
          run_test!
        end
      end
    end
  end

  path '/api/v1/projects/{id}' do
    put('update project') do
      consumes 'multipart/form-data'
      produces 'application/json'
      tags :projects

      security [basicAuth: []]
      parameter name: :id, in: :path, type: :string, description: 'id'
      parameter name: :name, in: :formData, type: :string, required: true

      context 'when valid params' do
        let(:id) { create(:project, user:).id }
        let(:name) { 'Work stuff' }

        before { authenticate(user) }

        response(200, 'successful') do
          schema type: :object, '$ref': '#/definitions/single_project'

          run_test! do
            parsed_body = JSON.parse(response.body)

            expect(parsed_body['data']['attributes']['name']).to eq('Work stuff')
            expect(response.body).to match_response_schema(Api::Schemas::Project::SINGLE_SCHEMA)
          end
        end
      end

      context 'when empty name' do
        let(:id) { create(:project, user:).id }
        let(:name) { nil }

        before { authenticate(user) }

        response(422, 'unprocessable_entity') do
          schema type: :object,
                 properties: {
                   errors: { type: :object }
                 }

          run_test!
        end
      end

      context 'when duplicated name' do
        let(:project) { create(:project, user:) }
        let(:id) { create(:project, user:).id }
        let(:name) { project.name }

        before { authenticate(user) }

        response(422, 'unprocessable_entity') do
          schema type: :object,
                 properties: {
                   errors: { type: :object }
                 }

          run_test!
        end
      end

      context 'when unauthorized' do
        let(:id) { create(:project).id }
        let(:name) { 'Work stuff' }

        response(401, 'unauthorized') do
          run_test!
        end
      end
    end
  end

  path '/api/v1/projects/{id}' do
    delete('delete project') do
      tags :projects

      security [basicAuth: []]
      parameter name: :id, in: :path, type: :string, description: 'id'

      context 'when valid params' do
        let(:id) { create(:project, user:).id }

        before { authenticate(user) }

        response(204, 'no_content') do
          run_test!
        end
      end

      context 'when unauthorized' do
        let(:id) { create(:project, user:).id }

        response(401, 'unauthorized') do
          run_test!
        end
      end
    end
  end
end

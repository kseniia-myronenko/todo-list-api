require 'swagger_helper'

RSpec.describe 'projects' do
  let!(:user) { create(:user, password: Helpers::UserAuthHelper::PASSWORD) }

  path '/api/v1' do
    get('show projects') do
      tags :projects
      produces 'application/json'
      security [basicAuth: []]

      context 'when with zero projects' do
        let(:Authorization) { basic_token(user) }

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
        let(:Authorization) { basic_token(user) }

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
        let(:Authorization) { nil }

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
        let(:Authorization) { basic_token(user) }
        let(:name) { 'Project name' }

        before { authenticate(user) }

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
        let(:Authorization) { basic_token(user) }
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
        let(:Authorization) { basic_token(user) }
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
        let(:Authorization) { nil }
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
      parameter name: :position,
                in: :query,
                type: :string,
                enum: %w[asc desc],
                required: false,
                description: "Sorting current project's tasks by position asc or desc."

      parameter name: :created_at,
                in: :query,
                type: :string,
                enum: %w[asc desc],
                required: false,
                description: "Sorting current project's tasks by created_at asc or desc."

      context 'when authenticated' do
        let(:Authorization) { basic_token(user) }

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

      context 'when sorting tasks with position asc/desc' do
        let(:id) { create(:project, user:).id }
        let!(:task_list) { create_list(:task, 3, project_id: id) }
        let(:Authorization) { basic_token(user) }

        before { authenticate(user) }

        response(200, 'successful') do
          let(:position) { 'asc' }

          schema type: :object, '$ref': '#/definitions/single_project'

          run_test! do
            parsed_body = JSON.parse(response.body)
            expect(parsed_body['data']['attributes']['tasks'].first['id']).to eq(task_list[0].id)
            expect(parsed_body['data']['attributes']['tasks'].second['id']).to eq(task_list[1].id)
            expect(parsed_body['data']['attributes']['tasks'].third['id']).to eq(task_list[2].id)
            expect(response.body).to match_response_schema(Api::Schemas::Project::SINGLE_SCHEMA)
          end
        end

        response(200, 'successful') do
          let(:position) { 'desc' }

          schema type: :object, '$ref': '#/definitions/single_project'

          run_test! do
            parsed_body = JSON.parse(response.body)
            expect(parsed_body['data']['attributes']['tasks'].first['id']).to eq(task_list[2].id)
            expect(parsed_body['data']['attributes']['tasks'].second['id']).to eq(task_list[1].id)
            expect(parsed_body['data']['attributes']['tasks'].third['id']).to eq(task_list[0].id)
            expect(response.body).to match_response_schema(Api::Schemas::Project::SINGLE_SCHEMA)
          end
        end
      end

      context 'when sorting tasks with created_at' do
        let(:Authorization) { basic_token(user) }
        let(:id) { create(:project, user:).id }
        let!(:task_list) { create_list(:task, 3, project_id: id) }

        before { authenticate(user) }

        response(200, 'successful') do
          let(:created_at) { 'asc' }

          schema type: :object, '$ref': '#/definitions/single_project'

          run_test! do
            parsed_body = JSON.parse(response.body)
            expect(parsed_body['data']['attributes']['tasks'].first['id']).to eq(task_list[0].id)
            expect(parsed_body['data']['attributes']['tasks'].second['id']).to eq(task_list[1].id)
            expect(parsed_body['data']['attributes']['tasks'].third['id']).to eq(task_list[2].id)
            expect(response.body).to match_response_schema(Api::Schemas::Project::SINGLE_SCHEMA)
          end
        end

        response(200, 'successful') do
          let(:created_at) { 'desc' }

          schema type: :object, '$ref': '#/definitions/single_project'

          run_test! do
            parsed_body = JSON.parse(response.body)
            expect(parsed_body['data']['attributes']['tasks'].first['id']).to eq(task_list[2].id)
            expect(parsed_body['data']['attributes']['tasks'].second['id']).to eq(task_list[1].id)
            expect(parsed_body['data']['attributes']['tasks'].third['id']).to eq(task_list[0].id)
            expect(response.body).to match_response_schema(Api::Schemas::Project::SINGLE_SCHEMA)
          end
        end
      end

      context 'when unauthorized' do
        let(:Authorization) { nil }
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
        let(:Authorization) { basic_token(user) }

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
        let(:Authorization) { basic_token(user) }
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
        let(:Authorization) { basic_token(user) }
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
        let(:Authorization) { nil }
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
        let(:Authorization) { basic_token(user) }
        let(:id) { create(:project, user:).id }

        before { authenticate(user) }

        response(204, 'no_content') do
          run_test!
        end
      end

      context 'when unauthorized' do
        let(:Authorization) { nil }
        let(:id) { create(:project, user:).id }

        response(401, 'unauthorized') do
          run_test!
        end
      end
    end
  end
end

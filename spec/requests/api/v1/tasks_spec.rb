require 'swagger_helper'

RSpec.describe 'api/v1/tasks', type: :request do
  let!(:user) { create(:user, password: Helpers::UserAuthHelper::PASSWORD) }

  path '/api/v1/projects/{project_id}/tasks' do
    post('create task') do
      parameter name: 'project_id', in: :path, type: :string, description: 'project_id'
      parameter name: :name, in: :formData, type: :string, required: true
      parameter name: :done, in: :formData, type: :boolean, required: false
      parameter name: :deadline, in: :formData, type: :date, required: false

      consumes 'multipart/form-data'
      produces 'application/json'
      security [basicAuth: []]
      tags :tasks

      context 'when valid params' do
        let(:Authorization) { basic_token(user) }
        let(:project_id) { create(:project, user:).id }
        let(:name) { 'Task name' }

        before { authenticate(user) }

        response(201, 'created') do
          schema type: :object, '$ref': '#/definitions/single_task'

          run_test! do
            parsed_body = JSON.parse(response.body)

            expect(response.body).to match_response_schema(Api::Schemas::Task::SINGLE_SCHEMA)
            expect(parsed_body['data']['attributes']['name']).to eq('Task name')
          end
        end
      end

      context 'when empty name' do
        let(:Authorization) { basic_token(user) }
        let(:project_id) { create(:project, user:).id }
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

      context 'when unauthorized' do
        let(:Authorization) { nil }
        let(:project_id) { create(:project, user:).id }
        let(:name) { 'Task name' }

        response(401, 'unauthorized') do
          run_test!
        end
      end
    end
  end

  path '/api/v1/projects/{project_id}/tasks/{id}' do
    get('show task') do
      produces 'application/json'
      security [basicAuth: []]
      tags :tasks

      parameter name: 'project_id', in: :path, type: :string, description: 'project_id'
      parameter name: 'id', in: :path, type: :string, description: 'id'

      context 'when authenticated' do
        let(:Authorization) { basic_token(user) }

        before { authenticate(user) }

        response(200, 'successful') do
          let(:project_id) { create(:project, user:).id }
          let(:id) { create(:task, project_id:).id }

          schema type: :object, '$ref': '#/definitions/single_task'

          run_test! do
            parsed_body = JSON.parse(response.body)

            expect(parsed_body['data']['id']).to eq(id)
            expect(response.body).to match_response_schema(Api::Schemas::Task::SINGLE_SCHEMA)
          end
        end

        response(404, 'not_found') do
          let(:project_id) { create(:project, user:).id }
          let(:id) { "#{create(:task, project_id:).id}id" }

          run_test!
        end
      end

      context 'when unauthorized' do
        let(:Authorization) { nil }
        let(:project_id) { create(:project, user:).id }
        let(:id) { create(:task, project_id:).id }

        response(401, 'unauthorized') do
          run_test!
        end
      end
    end

    put('update task') do
      parameter name: 'project_id', in: :path, type: :string, description: 'project_id'
      parameter name: 'id', in: :path, type: :string, description: 'id'
      parameter name: :name, in: :formData, type: :string, required: true

      consumes 'multipart/form-data'
      produces 'application/json'
      security [basicAuth: []]
      tags :tasks

      context 'when valid params' do
        let(:Authorization) { basic_token(user) }
        let(:project_id) { create(:project, user:).id }
        let(:id) { create(:task, project_id:).id }
        let(:name) { 'Updated task name' }

        before { authenticate(user) }

        response(200, 'successfull') do
          schema type: :object, '$ref': '#/definitions/single_task'

          run_test! do
            parsed_body = JSON.parse(response.body)

            expect(response.body).to match_response_schema(Api::Schemas::Task::SINGLE_SCHEMA)
            expect(parsed_body['data']['attributes']['name']).to eq('Updated task name')
          end
        end
      end

      context 'when empty name' do
        let(:Authorization) { basic_token(user) }
        let(:project_id) { create(:project, user:).id }
        let(:id) { create(:task, project_id:).id }
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

      context 'when unauthorized' do
        let(:Authorization) { nil }
        let(:project_id) { create(:project, user:).id }
        let(:id) { create(:task, project_id:).id }
        let(:name) { 'Task name' }

        response(401, 'unauthorized') do
          run_test!
        end
      end
    end

    delete('delete task') do
      parameter name: 'project_id', in: :path, type: :string, description: 'project_id'
      parameter name: 'id', in: :path, type: :string, description: 'id'

      produces 'application/json'
      security [basicAuth: []]
      tags :tasks

      context 'when authenticated' do
        let(:Authorization) { basic_token(user) }

        before { authenticate(user) }

        response(204, 'no_content') do
          let(:project_id) { create(:project, user:).id }
          let(:id) { create(:task, project_id:).id }

          run_test!
        end

        response(404, 'not_found') do
          let(:project_id) { create(:project, user:).id }
          let(:id) { "#{create(:task, project_id:).id}id" }

          run_test!
        end
      end

      context 'when unauthorized' do
        let(:Authorization) { nil }
        let(:project_id) { create(:project, user:).id }
        let(:id) { create(:task, project_id:).id }

        response(401, 'unauthorized') do
          run_test!
        end
      end
    end
  end
end

require 'swagger_helper'

RSpec.describe 'api/v1/comments', type: :request do
  let!(:user) { create(:user, password: Helpers::UserAuthHelper::PASSWORD) }

  path '/api/v1/projects/{project_id}/tasks/{task_id}/comments' do
    post('create comment') do
      parameter name: 'project_id', in: :path, type: :string, description: 'project_id'
      parameter name: 'task_id', in: :path, type: :string, description: 'task_id'
      parameter name: :content, type: :text, in: :formData, required: true, description: 'text of the comment'

      tags :comments
      consumes 'multipart/form-data'
      produces 'application/json'
      security [basicAuth: []]

      context 'when authenticated' do
        before { authenticate(user) }

        context 'when valid params' do
          let(:project_id) { create(:project, user:).id }
          let(:task_id) { create(:task, project_id:).id }
          let(:content) { 'Text of the comment.' }

          response(201, 'created') do
            schema type: :object, '$ref': '#/definitions/comment'

            run_test! do
              parsed_body = JSON.parse(response.body)
              expect(response.body).to match_response_schema(Api::Schemas::Comment::SINGLE_SCHEMA)
              expect(parsed_body.dig('data', 'attributes', 'content')).to eq(content)
            end
          end
        end

        context 'when short comment' do
          let(:project_id) { create(:project, user:).id }
          let(:task_id) { create(:task, project_id:).id }
          let(:content) { 'Text.' }

          response(422, 'unprocessable_entity') do
            schema type: :object,
                   properties: {
                     errors: { type: :object }
                   }

            run_test!
          end
        end

        context 'when long comment' do
          let(:project_id) { create(:project, user:).id }
          let(:task_id) { create(:task, project_id:).id }
          let(:content) { 'T' * (Comment::COMMENT_MAX_LENGTH + 1) }

          response(422, 'unprocessable_entity') do
            schema type: :object,
                   properties: {
                     errors: { type: :object }
                   }

            run_test!
          end
        end

        context 'when empty comment' do
          let(:project_id) { create(:project, user:).id }
          let(:task_id) { create(:task, project_id:).id }
          let(:content) { nil }

          response(422, 'unprocessable_entity') do
            schema type: :object,
                   properties: {
                     errors: { type: :object }
                   }

            run_test!
          end
        end

        context 'when not found the task' do
          let(:project_id) { create(:project, user:).id }
          let(:task_id) { "#{create(:task, project_id:).id}id" }
          let(:content) { 'Text of the comment.' }

          response(404, 'not_found') do
            run_test!
          end
        end
      end

      context 'when unauthorised' do
        let(:project_id) { create(:project, user:).id }
        let(:task_id) { create(:task, project_id:).id }
        let(:content) { 'Text of the comment.' }

        response(401, 'unauthorised') do
          run_test!
        end
      end
    end
  end

  path '/api/v1/projects/{project_id}/tasks/{task_id}/comments/{id}' do
    get('show comment') do
      parameter name: 'project_id', in: :path, type: :string, description: 'project_id'
      parameter name: 'task_id', in: :path, type: :string, description: 'task_id'
      parameter name: 'id', in: :path, type: :string, description: 'id'

      tags :comments
      produces 'application/json'
      security [basicAuth: []]

      context 'when authenticated' do
        before { authenticate(user) }

        context 'when valid params' do
          let(:project_id) { create(:project, user:).id }
          let(:task_id) { create(:task, project_id:).id }
          let(:id) { create(:comment, task_id:).id }

          response(200, 'successful') do
            schema type: :object, '$ref': '#/definitions/comment'

            run_test! do
              parsed_body = JSON.parse(response.body)
              expect(response.body).to match_response_schema(Api::Schemas::Comment::SINGLE_SCHEMA)
              expect(parsed_body.dig('data', 'id')).to eq(id)
            end
          end
        end

        context 'when invalid id' do
          let(:project_id) { create(:project, user:).id }
          let(:task_id) { create(:task, project_id:).id }
          let(:id) { "#{create(:comment, task_id:).id}id" }

          response(404, 'not_found') do
            run_test!
          end
        end
      end

      context 'when unauthorised' do
        let(:project_id) { create(:project, user:).id }
        let(:task_id) { create(:task, project_id:).id }
        let(:id) { create(:comment, task_id:).id }

        response(401, 'unauthorised') do
          run_test!
        end
      end
    end

    put('update comment') do
      parameter name: 'project_id', in: :path, type: :string, description: 'project_id'
      parameter name: 'task_id', in: :path, type: :string, description: 'task_id'
      parameter name: :content, type: :text, in: :formData, required: true, description: 'text of the comment'
      parameter name: 'id', in: :path, type: :string, description: 'id'

      tags :comments
      consumes 'multipart/form-data'
      produces 'application/json'
      security [basicAuth: []]

      context 'when authenticated' do
        before { authenticate(user) }

        context 'when valid params' do
          let(:project_id) { create(:project, user:).id }
          let(:task_id) { create(:task, project_id:).id }
          let(:content) { 'New comment.' }
          let(:id) { create(:comment, task_id:).id }

          response(200, 'successful') do
            schema type: :object, '$ref': '#/definitions/comment'

            run_test! do
              parsed_body = JSON.parse(response.body)
              expect(response.body).to match_response_schema(Api::Schemas::Comment::SINGLE_SCHEMA)
              expect(parsed_body.dig('data', 'attributes', 'content')).to eq(content)
            end
          end
        end

        context 'when invalid id' do
          let(:project_id) { create(:project, user:).id }
          let(:task_id) { create(:task, project_id:).id }
          let(:comment) { create(:comment, task_id:) }
          let(:content) { comment.content }
          let(:id) { "#{comment.id}id" }

          response(404, 'not_found') do
            run_test!
          end
        end

        context 'when long comment' do
          let(:project_id) { create(:project, user:).id }
          let(:task_id) { create(:task, project_id:).id }
          let(:comment) { create(:comment, task_id:) }
          let(:id) { comment.id }
          let(:content) { 'T' * (Comment::COMMENT_MAX_LENGTH + 1) }

          response(422, 'unprocessable_entity') do
            schema type: :object,
                   properties: {
                     errors: { type: :object }
                   }

            run_test!
          end
        end

        context 'when short comment' do
          let(:project_id) { create(:project, user:).id }
          let(:task_id) { create(:task, project_id:).id }
          let(:comment) { create(:comment, task_id:) }
          let(:id) { comment.id }
          let(:content) { 'T' }

          response(422, 'unprocessable_entity') do
            schema type: :object,
                   properties: {
                     errors: { type: :object }
                   }

            run_test!
          end
        end

        context 'when empty comment' do
          let(:project_id) { create(:project, user:).id }
          let(:task_id) { create(:task, project_id:).id }
          let(:comment) { create(:comment, task_id:) }
          let(:id) { comment.id }
          let(:content) { nil }

          response(422, 'unprocessable_entity') do
            schema type: :object,
                   properties: {
                     errors: { type: :object }
                   }

            run_test!
          end
        end
      end

      context 'when unauthorised' do
        let(:project_id) { create(:project, user:).id }
        let(:task_id) { create(:task, project_id:).id }
        let(:comment) { create(:comment, task_id:) }
        let(:content) { comment.content }
        let(:id) { create(:comment, task_id:).id }

        response(401, 'unauthorised') do
          run_test!
        end
      end
    end

    delete('delete comment') do
      parameter name: 'project_id', in: :path, type: :string, description: 'project_id'
      parameter name: 'task_id', in: :path, type: :string, description: 'task_id'
      parameter name: 'id', in: :path, type: :string, description: 'id'

      tags :comments
      produces 'application/json'
      security [basicAuth: []]

      context 'when authenticated' do
        let(:project_id) { create(:project, user:).id }
        let(:task_id) { create(:task, project_id:).id }
        let(:id) { create(:comment, task_id:).id }

        before { authenticate(user) }

        response(204, 'no_content') do
          run_test!
        end
      end

      context 'when unauthorised' do
        let(:project_id) { create(:project, user:).id }
        let(:task_id) { create(:task, project_id:).id }
        let(:id) { create(:comment, task_id:).id }

        response(401, 'unauthorised') do
          run_test!
        end
      end
    end
  end
end

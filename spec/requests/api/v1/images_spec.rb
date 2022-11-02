require 'swagger_helper'

RSpec.describe 'api/v1/images' do
  let!(:user) { create(:user, password: Helpers::UserAuthHelper::PASSWORD) }

  path '/api/v1/projects/{project_id}/tasks/{task_id}/comments/{comment_id}/images' do
    post('create image') do
      parameter name: 'project_id', in: :path, type: :string, description: 'project_id'
      parameter name: 'task_id', in: :path, type: :string, description: 'task_id'
      parameter name: 'comment_id', in: :path, type: :string, description: 'comment_id'
      parameter name: :image, type: :file, in: :formData, required: true, description: 'image'

      tags :images
      consumes 'multipart/form-data'
      produces 'application/json'
      security [basicAuth: []]

      context 'when authenticated' do
        let(:Authorization) { basic_token(user) }

        before { authenticate(user) }

        context 'when valid params' do
          let(:project_id) { create(:project, user:).id }
          let(:task_id) { create(:task, project_id:).id }
          let(:comment_id) { create(:comment, task_id:).id }
          let(:item) { create(:image, comment_id:) }
          let(:image) { item.image_data }

          response(201, 'created') do
            schema type: :object, '$ref': '#/definitions/image'

            run_test! do
              parsed_body = JSON.parse(response.body)
              image_data = JSON.parse(image)
              expect(response.body).to match_response_schema(Api::Schemas::Image::SINGLE_SCHEMA)
              expect(parsed_body.dig('data', 'attributes', 'image', 'metadata',
                                     'filename')).to eq(image_data['metadata']['filename'])
            end
          end
        end

        context 'when invalid params' do
          let(:project_id) { create(:project, user:).id }
          let(:task_id) { create(:task, project_id:).id }
          let(:comment_id) { create(:comment, task_id:).id }
          let(:image) { nil }

          response(422, 'unprocessable_entity') do
            schema type: :object,
                   properties: {
                     errors: { type: :object }
                   }

            run_test!
          end
        end

        context 'when without comment' do
          let(:project_id) { create(:project, user:).id }
          let(:task_id) { create(:task, project_id:).id }
          let(:comment_id) { "#{create(:comment, task_id:).id}id" }
          let(:image) { build(:image, comment_id:).image_data }

          response(404, 'not_found') do
            run_test!
          end
        end
      end

      context 'when unauthorised' do
        let(:Authorization) { nil }
        let(:project_id) { create(:project, user:).id }
        let(:task_id) { create(:task, project_id:).id }
        let(:comment_id) { create(:comment, task_id:).id }
        let(:image) { build(:image, comment_id:).image_data }

        response(401, 'unauthorised') do
          run_test!
        end
      end
    end
  end

  path '/api/v1/projects/{project_id}/tasks/{task_id}/comments/{comment_id}/images/{id}' do
    put('update image') do
      parameter name: 'project_id', in: :path, type: :string, description: 'project_id'
      parameter name: 'task_id', in: :path, type: :string, description: 'task_id'
      parameter name: 'comment_id', in: :path, type: :string, description: 'comment_id'
      parameter name: :image, type: :file, in: :formData, required: true, description: 'image'
      parameter name: 'id', in: :path, type: :string, description: 'id'

      tags :images
      consumes 'multipart/form-data'
      produces 'application/json'
      security [basicAuth: []]

      context 'when authenticated' do
        let(:Authorization) { basic_token(user) }
        let(:project_id) { create(:project, user:).id }
        let(:task_id) { create(:task, project_id:).id }
        let(:comment_id) { create(:comment, task_id:).id }
        let(:item) { create(:image, comment_id:) }
        let(:image) { item.image_data }

        before { authenticate(user) }

        context 'when valid params' do
          let(:id) { item.id }

          response(200, 'successful') do
            schema type: :object, '$ref': '#/definitions/image'

            before do
              item.image_data = build(:image, :jpg_format).image_data
            end

            run_test! do
              parsed_body = JSON.parse(response.body)
              expect(response.body).to match_response_schema(Api::Schemas::Image::SINGLE_SCHEMA)
              expect(parsed_body.dig('data', 'attributes', 'image', 'metadata',
                                     'filename')).to eq('acceptable_size_image-1.jpg')
            end
          end
        end

        context 'when invalid id' do
          let(:id) { "#{item.id}id" }

          response(404, 'not_found') do
            run_test!
          end
        end

        context 'when invalid type' do
          let(:id) { item.id }

          before do
            item.image_data = build(:image, :invalid_type).image_data
          end

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
        let(:Authorization) { nil }
        let(:project_id) { create(:project, user:).id }
        let(:task_id) { create(:task, project_id:).id }
        let(:comment_id) { create(:comment, task_id:).id }
        let(:item) { create(:image, comment_id:) }
        let(:image) { item.image_data }
        let(:id) { item.id }

        response(401, 'unauthorised') do
          run_test!
        end
      end
    end
  end
end

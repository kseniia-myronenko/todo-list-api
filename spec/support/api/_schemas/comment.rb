module Api
  module Schemas
    class Comment < ApplicationSchema
      COMMENT_SCHEMA = Dry::Schema.Params do
        required(:id).filled(:string)
        required(:type).filled(:string)
        required(:attributes).hash do
          required(:content).filled(:string)
          required(:images).array(:hash) do
            required(:id).filled(:string)
            required(:comment_id).filled(:string)
            required(:created_at).filled(:string)
            required(:updated_at).filled(:string)
            required(:image_data).filled(:string)
          end
        end
        required(:relationships).hash do
          required(:task).hash do
            required(:data).hash do
              required(:id).filled(:string)
              required(:type).filled(:string)
            end
          end
        end
      end

      SINGLE_SCHEMA = Dry::Schema.JSON do
        required(:data).hash(COMMENT_SCHEMA)
      end
    end
  end
end

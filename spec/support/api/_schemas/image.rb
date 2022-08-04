module Api
  module Schemas
    class Image < ApplicationSchema
      IMAGE_SCHEMA = Dry::Schema.Params do
        required(:id).filled(:string)
        required(:type).filled(:string)
        required(:attributes).hash do
          required(:image).hash do
            required(:id).filled(:string)
            required(:storage).filled(:string)
            required(:metadata).hash do
              required(:filename).filled(:string)
              required(:size).filled(:integer)
              required(:mime_type).filled(:string)
              required(:width).filled(:integer)
              required(:height).filled(:integer)
            end
          end
        end
        required(:relationships).hash do
          required(:comment).hash do
            required(:data).hash do
              required(:id).filled(:string)
              required(:type).filled(:string)
            end
          end
        end
      end

      SINGLE_SCHEMA = Dry::Schema.JSON do
        required(:data).hash(IMAGE_SCHEMA)
      end
    end
  end
end

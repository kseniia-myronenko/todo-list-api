module Api
  module Schemas
    class Task < ApplicationSchema
      TASK = Dry::Schema.Params do
        required(:id).filled(:string)
        required(:type).filled(:string)
        required(:attributes).hash do
          required(:name).filled(:string)
          required(:done).filled(:bool)
          required(:deadline).maybe(:string)
          required(:position).filled(:integer)
        end
        required(:relationships).hash do
          required(:project).hash do
            required(:data).hash do
              required(:id).filled(:string)
              required(:type).filled(:string)
            end
          end
        end
      end

      MANY_SCHEMA = Dry::Schema.JSON do
        required(:data).array(TASK)
      end

      SINGLE_SCHEMA = Dry::Schema.JSON do
        required(:data).hash(TASK)
      end
    end
  end
end

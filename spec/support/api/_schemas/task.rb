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
          required(:comments).array(:hash) do
            required(:id).filled(:string)
            required(:content).filled(:string)
            required(:task_id).filled(:string)
            required(:created_at).filled(:string)
            required(:updated_at).filled(:string)
          end
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

      SINGLE_SCHEMA = Dry::Schema.JSON do
        required(:data).hash(TASK)
      end
    end
  end
end

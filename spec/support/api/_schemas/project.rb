module Api
  module Schemas
    class Project < ApplicationSchema
      PROJECTS = Dry::Schema.Params do
        required(:id).filled(:string)
        required(:type).filled(:string)
        required(:attributes).hash do
          required(:name).filled(:string)
        end
        required(:relationships).hash do
          required(:user).hash do
            required(:data).hash do
              required(:id).filled(:string)
              required(:type).filled(:string)
            end
          end
        end
      end

      SINGLE_PROJECT = Dry::Schema.Params do
        required(:id).filled(:string)
        required(:type).filled(:string)
        required(:attributes).hash do
          required(:name).filled(:string)
          required(:tasks).array(:hash) do
            required(:id).filled(:string)
            required(:name).filled(:string)
            required(:project_id).filled(:string)
            required(:created_at).filled(:string)
            required(:updated_at).filled(:string)
            required(:done).filled(:bool)
            required(:deadline).maybe(:string)
            required(:position).filled(:integer)
          end
        end
        required(:relationships).hash do
          required(:user).hash do
            required(:data).hash do
              required(:id).filled(:string)
              required(:type).filled(:string)
            end
          end
        end
      end

      MANY_SCHEMA = Dry::Schema.JSON do
        required(:data).array(PROJECTS)
        optional(:included).array(:hash)
      end

      SINGLE_SCHEMA = Dry::Schema.JSON do
        required(:data).hash(SINGLE_PROJECT)
      end
    end
  end
end

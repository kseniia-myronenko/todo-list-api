module Api
  module Schemas
    class Project < ApplicationSchema
      PROJECT = Dry::Schema.Params do
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

      MANY_SCHEMA = Dry::Schema.JSON do
        required(:data).array(PROJECT)
      end

      SINGLE_SCHEMA = Dry::Schema.JSON do
        required(:data).hash(PROJECT)
      end
    end
  end
end

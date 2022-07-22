module Api
  module Schemas
    class Project < ApplicationSchema
      PROJECT = Dry::Schema.Params do
        required(:data).array(:hash) do
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
      end
    end
  end
end

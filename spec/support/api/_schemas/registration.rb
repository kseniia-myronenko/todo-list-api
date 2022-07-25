module Api
  module Schemas
    class Registration < ApplicationSchema
      MAIN = Dry::Schema.Params do
        required(:user).filled(:string)
        required(:message).filled(:string)
      end
    end
  end
end

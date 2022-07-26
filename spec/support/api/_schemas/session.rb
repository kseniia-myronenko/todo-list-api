module Api
  module Schemas
    class Session < ApplicationSchema
      MAIN = Dry::Schema.Params do
        required(:user).filled(:string)
        required(:logged_in).filled(:bool)
        required(:message).filled(:string)
      end
    end
  end
end

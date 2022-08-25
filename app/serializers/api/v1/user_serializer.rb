module Api
  module V1
    class UserSerializer < ApplicationSerializer
      set_type :user
      attributes :username
    end
  end
end

module Api
  module V1
    class ProjectSerializer < ApplicationSerializer
      set_type :project
      attributes :name
      belongs_to :user, serializer: Api::V1::UserSerializer
    end
  end
end
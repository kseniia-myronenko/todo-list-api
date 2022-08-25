module Api
  module V1
    class ProjectsSerializer < ApplicationSerializer
      set_type :project
      attributes :name
      belongs_to :user, serializer: Api::V1::UserSerializer
      has_many :tasks, serializer: Api::V1::TaskSerializer
    end
  end
end

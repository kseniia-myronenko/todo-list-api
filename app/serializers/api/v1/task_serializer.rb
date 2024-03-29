module Api
  module V1
    class TaskSerializer < ApplicationSerializer
      set_type :task
      attributes :name, :done, :deadline, :position
      attribute :comments
      belongs_to :project, serializer: Api::V1::ProjectsSerializer
    end
  end
end

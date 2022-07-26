module Api
  module V1
    class TaskSerializer < ApplicationSerializer
      set_type :task
      attributes :name, :done, :deadline
      belongs_to :project, serializer: Api::V1::ProjectSerializer
    end
  end
end

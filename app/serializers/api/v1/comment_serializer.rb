module Api
  module V1
    class CommentSerializer < ApplicationSerializer
      set_type :comment
      attributes :content
      attribute :images

      belongs_to :task, serializer: Api::V1::TaskSerializer
    end
  end
end

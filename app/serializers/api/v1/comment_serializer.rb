module Api
  module V1
    class CommentSerializer < ApplicationSerializer
      set_type :comment
      attributes :content

      belongs_to :task, serializer: Api::V1::TaskSerializer
      has_many :images, serializer: Api::V1::ImageSerializer
    end
  end
end

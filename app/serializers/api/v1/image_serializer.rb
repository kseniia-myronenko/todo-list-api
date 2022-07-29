module Api
  module V1
    class ImageSerializer < ApplicationSerializer
      set_type :image
      attributes :image
      belongs_to :comment, serializer: Api::V1::CommentSerializer
    end
  end
end

module Api
  module V1
    class SingleProjectSerializer < ApplicationSerializer
      set_type :project
      attributes :name
      belongs_to :user, serializer: Api::V1::UserSerializer
      attribute :tasks do |object, params|
        object.tasks.order(params[:order])
      end
    end
  end
end

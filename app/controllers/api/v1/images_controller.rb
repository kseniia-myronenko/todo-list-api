module Api
  module V1
    class ImagesController < AuthorizedController
      def create
        @image = comment.images.create(image_params)

        response = if @image.valid?
                     { json: Api::V1::ImageSerializer.new(@image), status: :created }
                   else
                     { json: { errors: @image.errors }, status: :unprocessable_entity }
                   end

        render response
      end

      def update
        @image = comment.images.find(params[:id])
        response = if @image.update(image_params)
                     { json: Api::V1::ImageSerializer.new(@image), status: :ok }
                   else
                     { json: { errors: @image.errors }, status: :unprocessable_entity }
                   end

        render response
      end

      private

      def image_params
        params.permit(:image, :remove_image)
      end

      def project
        current_user.projects.find(params[:project_id])
      end

      def task
        project.tasks.find(params[:task_id])
      end

      def comment
        task.comments.find(params[:comment_id])
      end
    end
  end
end

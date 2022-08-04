module Api
  module V1
    class CommentsController < AuthorizedController
      before_action :set_task
      before_action :set_comment, except: %i[create]

      def show
        render json: Api::V1::CommentSerializer.new(@comment), status: :ok
      end

      def create
        @comment = @task.comments.create(comment_params)

        response = if @comment.valid?
                     { json: Api::V1::CommentSerializer.new(@comment), status: :created }
                   else
                     { json: { errors: @comment.errors }, status: :unprocessable_entity }
                   end

        render response
      end

      def update
        response = if @comment.update(comment_params)
                     { json: Api::V1::CommentSerializer.new(@comment), status: :ok }
                   else
                     { json: { errors: @comment.errors }, status: :unprocessable_entity }
                   end

        render response
      end

      def destroy
        @comment.destroy
        head :no_content
      end

      private

      def comment_params
        params.permit(:content)
      end

      def project
        current_user.projects.find(params[:project_id])
      end

      def set_task
        @task = project.tasks.find(params[:task_id])
      end

      def set_comment
        @comment = @task.comments.find(params[:id])
      end
    end
  end
end

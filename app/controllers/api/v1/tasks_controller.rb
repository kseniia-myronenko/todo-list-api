module Api
  module V1
    class TasksController < AuthorizedController
      before_action :set_project
      before_action :set_task, except: %i[create]

      def show
        render json: Api::V1::TaskSerializer.new(@task), status: :ok
      end

      def create
        @task = @project.tasks.create(task_params)

        response = if @task.valid?
                     { json: Api::V1::TaskSerializer.new(@task), status: :created }
                   else
                     { json: { errors: @task.errors }, status: :unprocessable_entity }
                   end

        render response
      end

      def update
        response = if @task.update(task_params)
                     { json: Api::V1::TaskSerializer.new(@task), status: :ok }
                   else
                     { json: { errors: @task.errors }, status: :unprocessable_entity }
                   end

        render response
      end

      def destroy
        @task.destroy
        head :no_content
      end

      private

      def task_params
        params.permit(:name, :position, :done, :deadline)
      end

      def set_project
        @project = current_user.projects.find(params[:project_id])
      end

      def set_task
        @task = @project.tasks.find(params[:id])
      end
    end
  end
end

module Api
  module V1
    class TasksController < AuthorizedController
      before_action :set_task, except: :create

      def show
        render json: Api::V1::TaskSerializer.new(set_task.model), status: :ok
      end

      def create
        task_form = TaskForm.new(project.tasks.new)

        response = if task_form.validate(task_params)
                     task_form.save
                     { json: Api::V1::TaskSerializer.new(task_form.model), status: :created }
                   else
                     { json: { errors: task_form.errors }, status: :unprocessable_entity }
                   end

        render response
      end

      def update
        response = if set_task.validate(task_params)
                     set_task.model.update(task_params)
                     { json: Api::V1::TaskSerializer.new(set_task.model), status: :ok }
                   else
                     { json: { errors: set_task.errors }, status: :unprocessable_entity }
                   end

        render response
      end

      def destroy
        set_task.model.destroy
        head :no_content
      end

      private

      def task_params
        params.permit(:name, :position, :done, :deadline)
      end

      def project
        current_user.projects.find(params[:project_id])
      end

      def set_task
        TaskForm.new(project.tasks.find(params[:id]))
      end
    end
  end
end

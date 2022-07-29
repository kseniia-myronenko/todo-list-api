module Api
  module V1
    class ProjectsController < AuthorizedController
      before_action :set_project, except: %i[index create]

      def index
        @projects = current_user.projects
        render json: Api::V1::ProjectsSerializer.new(@projects), status: :ok
      end

      def show
        render json: Api::V1::SingleProjectSerializer.new(@project,
                                                          { params: { order: TasksSortService.call(params) } }),
               status: :ok
      end

      def create
        @project = current_user.projects.create(project_params)

        response = if @project.valid?
                     { json: Api::V1::SingleProjectSerializer.new(@project), status: :created }
                   else
                     { json: { errors: @project.errors }, status: :unprocessable_entity }
                   end

        render response
      end

      def update
        response = if @project.update(project_params)
                     { json: Api::V1::SingleProjectSerializer.new(@project), status: :ok }
                   else
                     { json: { errors: @project.errors }, status: :unprocessable_entity }
                   end

        render response
      end

      def destroy
        @project.destroy
        head :no_content
      end

      private

      def project_params
        params.permit(:name)
      end

      def set_project
        @project = current_user.projects.find(params[:id])
      end
    end
  end
end

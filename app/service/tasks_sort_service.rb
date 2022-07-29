class TasksSortService < ApplicationService
  def initialize(params)
    @params = params
  end

  def call
    define_sorting
  end

  private

  def define_sorting
    if @params[:position]
      { position: @params[:position] }
    elsif @params[:created_at]
      { created_at: @params[:created_at] }
    else
      { created_at: :asc }
    end
  end
end

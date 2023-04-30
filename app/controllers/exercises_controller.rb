class ExercisesController < ApplicationController
  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)
    @exercise.tags = exercise_params[:tags].split(',').map(&:strip)
    if @exercise.save
      redirect_to @exercise, notice: 'Exercise was successfully created.'
    else
      render :new
    end
  end

  def show
    @exercise = Exercise.find(params[:id])
  end
  
  def edit
    
  end

  private

  def exercise_params
    params.require(:exercise).permit(:name, :description, :equipment, :tags, :picture)
  end
end

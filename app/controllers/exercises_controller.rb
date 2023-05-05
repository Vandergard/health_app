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

  def search
    query = params[:query]
    @exercises = Exercise.where("name ILIKE ?", "%#{query}%")
                          .or(Exercise.where("tags::text[] @> ARRAY[?]::text[]", [query]))
                          .limit(10)
  
    render json: @exercises.to_json(only: [:id, :name, :description, :equipment, :tags])
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

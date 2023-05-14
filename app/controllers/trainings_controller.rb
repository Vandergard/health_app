class TrainingsController < ApplicationController
  def index
  end

  def new
  end

  def create
    training_params = params.require(:training).permit(:name, :category, :difficulty, :description, training_sets_attributes: [:exercise_id, :reps, :duration, :set_rest])
  
    training = Training.new(
      name: training_params[:name],
      category: training_params[:category],
      difficulty: training_params[:difficulty],
      description: training_params[:description]
    )
  
    if training.save
      training_params[:training_sets_attributes].each do |index, set_data|
        set = TrainingSet.create(
          exercise_id: set_data[:exercise_id].to_i,
          reps: set_data[:reps],
          duration: set_data[:duration],
          set_rest: set_data[:set_rest]
        )
        training.sets << set
      end 
      if training.save
        render json: { status: "success", message: "Training created successfully." }, status: :created
      else
        render json: { status: "error", message: "Error occurred while creating training.", errors: training.errors.full_messages  }, status: :unprocessable_entity
      end
    else
      render json: { status: "error", message: "Error occurred while creating training.", errors: training.errors.full_messages  }, status: :unprocessable_entity
    end
  end  

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

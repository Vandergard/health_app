class TrainingsController < ApplicationController
  def index
  end

  def new
  end

  def create
    training_params = params.require(:training).permit(:name, :category, :difficulty, :description, training_sets_attributes: [:exercise_id, :reps, :duration, :set_rest, :count, :description ])
  
    training = Training.new(
      name: training_params[:name],
      category: training_params[:category],
      difficulty: training_params[:difficulty],
      description: training_params[:description]
    )
  
    if training.save
      # this if need to convert json array to ruby hash (1:{}, 2:{})
      if training_params[:training_sets_attributes].is_a?(Array)
        training_sets_attributes_hash = Hash[training_params[:training_sets_attributes].map.with_index do |set_data, index|
          [index.to_s, set_data]
        end]
        training_params[:training_sets_attributes] = training_sets_attributes_hash
      end
      training_params[:training_sets_attributes].each do |index, set_data|
        if set_data
          set = TrainingSet.create(
          exercise_id: set_data[:exercise_id].to_i,
          reps: set_data[:reps],
          duration: set_data[:duration],
          set_rest: set_data[:set_rest],
          count: set_data[:count],
          description: set_data[:description]
          )
          training.sets << set
        else
          Rails.logger.debug "Unexpected nil in training_sets_attributes at index #{index}"
        end
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
    @training = Training.includes(training_sets: :exercise).find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

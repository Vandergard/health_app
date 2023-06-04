class TrainingsController < ApplicationController
  def index
  end

  def new
  end

  def create
    training_params = params.require(:training).permit(:name, :category, :difficulty, :description, training_sets_attributes: [:exercise_id, :reps, :duration, :set_rest, :count, :after_set_rest ])
  
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
          exercise = Exercise.find_by(id: set_data[:exercise_id].to_i)
          if exercise
            begin
              set = TrainingSet.create!(
                exercise_id: exercise.id,
                reps: set_data[:reps],
                duration: set_data[:duration],
                set_rest: set_data[:set_rest],
                count: set_data[:count]
              )
              Rails.logger.debug "Created set with id: #{set.id}"
              training.sets << set.id
              training.counts << set_data[:count]
              training.rests << set_data[:after_set_rest]
            rescue ActiveRecord::RecordInvalid => e
              Rails.logger.debug "Failed to create TrainingSet: #{e.message}"
            end
          else
            Rails.logger.debug "Exercise with id #{set_data[:exercise_id].to_i} does not exist"
          end
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
    @training = Training.find(params[:id])
    @training_sets = TrainingSet.where(id: @training.sets)
    # respond_to do |format|
    #   format.html # Renders the default HTML view (training.html.erb)
    #   format.json { render json: @training } # Renders the training details as JSON
    # end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end

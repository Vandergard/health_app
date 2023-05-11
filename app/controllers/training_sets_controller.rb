class TrainingSetsController < ApplicationController
  before_action :set_exercise, only: [:create]
  before_action :find_training_set, only: [:show, :edit, :update, :destroy]

  # GET /training_sets
  def index
    @training_sets = TrainingSet.all
  end

  # GET /training_sets/1
  def show
  end

  # GET /training_sets/new
  def new
    @training_set = TrainingSet.new
  end

  # GET /training_sets/1/edit
  def edit
  end

  # POST /training_sets
  def create
    @training_set = @exercise.training_sets.build(training_set_params)

    if @training_set.save
      render json: @training_set, status: :created
    else
      render json: @training_set.errors, status: :unprocessable_entity
    end
  end

  private

  def set_exercise
    @exercise = Exercise.find(params[:exercise_id].to_i)
  end

  # PATCH/PUT /training_sets/1
  def update
    if @training_set.update(training_set_params)
      redirect_to @training_set, notice: 'Training set was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /training_sets/1
  def destroy
    @training_set.destroy
    redirect_to training_sets_url, notice: 'Training set was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_training_set
      @training_set = TrainingSet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def training_set_params
      params.require(:training_set).permit(:name, :description, :exercise_id, :reps, :duration, :set_rest)
    end
end

class CountersController < ApplicationController
  before_action :set_counter, only: %i[ show edit update destroy ]

  # GET /counters or /counters.json
  def index
    set_counters
  end

  # GET /counters/1 or /counters/1.json
  def show
    if @counter.nil?
      render plain: "Not found", status: :not_found
    end
  end

  # GET /counters/new
  def new
    @counter = Counter.new
  end

  # GET /counters/1/edit
  def edit
  end

  # POST /counters or /counters.json
  def create
    @counter = Counter.new(counter_params)
    @counter.user_id = current_user.id

    respond_to do |format|
      if @counter.save
        format.html { redirect_to counter_url(@counter), notice: "Counter was successfully created." }
        format.json { render :show, status: :created, location: @counter }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @counter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /counters/1 or /counters/1.json
  def update
    if params[:commit] == "Up"
      @counter.up(current_user.id)
      redirect_to counters_url 
      return
    elsif params[:commit] == "Down"
      @counter.down(current_user.id)
      redirect_to counters_url 
      return
    elsif params[:commit] == "Reset"
      @counter.reset(current_user.id)
      redirect_to counters_url 
      return
    end
    respond_to do |format|
      if @counter.update(counter_params)
        format.html { redirect_to counter_url(@counter), notice: "Counter was successfully updated." }
        format.json { render :show, status: :ok, location: @counter }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @counter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /counters/1 or /counters/1.json
  def destroy
    @counter.destroy

    respond_to do |format|
      format.html { redirect_to counters_url, notice: "Counter was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_counters
    @counters = Counter.left_joins(:users)
                .where("counters.user_id = :user_id OR users.id = :user_id", user_id: current_user.id)

  end

  def set_counter
    set_counters
    @counter = @counters.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def counter_params
    params.require(:counter).permit(:name, :number)
  end

end

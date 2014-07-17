class AppendixesController < ApplicationController
  before_action :set_appendix, only: [:show, :edit, :update, :destroy]

  # GET /appendixes
  # GET /appendixes.json
  def index
    @appendixes = Appendix.all
  end

  # GET /appendixes/1
  # GET /appendixes/1.json
  def show
  end

  # GET /appendixes/new
  def new
    @appendix = Appendix.new
  end

  # GET /appendixes/1/edit
  def edit
  end

  # POST /appendixes
  # POST /appendixes.json
  def create
    @appendix = Appendix.new(appendix_params)

    respond_to do |format|
      if @appendix.save
        format.html { redirect_to @appendix, notice: 'Appendix was successfully created.' }
        format.json { render :show, status: :created, location: @appendix }
      else
        format.html { render :new }
        format.json { render json: @appendix.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appendixes/1
  # PATCH/PUT /appendixes/1.json
  def update
    respond_to do |format|
      if @appendix.update(appendix_params)
        format.html { redirect_to @appendix, notice: 'Appendix was successfully updated.' }
        format.json { render :show, status: :ok, location: @appendix }
      else
        format.html { render :edit }
        format.json { render json: @appendix.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appendixes/1
  # DELETE /appendixes/1.json
  def destroy
    @appendix.destroy
    respond_to do |format|
      format.html { redirect_to appendixes_url, notice: 'Appendix was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appendix
      @appendix = Appendix.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appendix_params
      params[:appendix].permit!
    end
end

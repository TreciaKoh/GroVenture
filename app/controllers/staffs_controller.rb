class StaffsController < ApplicationController
  before_action :set_staff, only: [:show, :edit, :update, :destroy]

  # GET /staffs
  # GET /staffs.json
  def index
    @staffs = Staff.all
  end

  # GET /staffs/1
  # GET /staffs/1.json
  def show
  end

  # GET /staffs/new
  def new
    @staff = Staff.new
    @education = @staff.educations.build
    @employmenthistory = @staff.employment_histories.build
  end

  # GET /staffs/1/edit
  def edit
  end

  # POST /staffs
  # POST /staffs.json
  def create
    @staff = Staff.new(staff_params)

    respond_to do |format|
      if @staff.save
        format.html { redirect_to @staff, notice: 'Staff was successfully created.' }
        format.json { render :show, status: :created, location: @staff }
      else
        format.html { render :new }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /staffs/1
  # PATCH/PUT /staffs/1.json
  def update
    respond_to do |format|
      if @staff.update(staff_params)
        format.html { redirect_to @staff, notice: 'Staff was successfully updated.' }
        format.json { render :show, status: :ok, location: @staff }
      else
        format.html { render :edit }
        format.json { render json: @staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /staffs/1
  # DELETE /staffs/1.json
  def destroy
    @staff.destroy
    respond_to do |format|
      format.html { redirect_to staffs_url, notice: 'Staff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_staff
      @staff = Staff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def staff_params
      # params.require(:staff).permit(:positionapplied, :salutation, :fullname, :address, :telephone, :dob, :birthplace, :race, :dialect, :nric, :colour, :citizenship, :sex, :religion, :incometaxno, :drivinglicenseno, :maritalstatus, :spousename, :spouseoccupation, :noofchildren, :agerange, :emergencyname, :emergencyrelationship, :emergencyaddress, :emergencytelephone, :servingbond, :salaryexpected, :dateavailable, :previousapplied, :previousdate, :previousposition, :languagespoken, :languagewritten, :physicaldisability, :majorillness, :staffid, :password, :profession, :company, :dateemployed, :dobchild, :department, :tier, :overwrittenleave, :overwrittenon )
      params.require(:staff).permit!
    end
end

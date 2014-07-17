require 'test_helper'

class StaffsControllerTest < ActionController::TestCase
  setup do
    @staff = staffs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:staffs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create staff" do
    assert_difference('Staff.count') do
      post :create, staff: { address: @staff.address, agerange: @staff.agerange, birthplace: @staff.birthplace, citizenship: @staff.citizenship, colour: @staff.colour, company: @staff.company, dateavailable: @staff.dateavailable, dateemployed: @staff.dateemployed, department: @staff.department, dialect: @staff.dialect, dob: @staff.dob, dobchild: @staff.dobchild, drivinglicenseno: @staff.drivinglicenseno, emergencyaddress: @staff.emergencyaddress, emergencyname: @staff.emergencyname, emergencyrelationship: @staff.emergencyrelationship, emergencytelephone: @staff.emergencytelephone, fullname: @staff.fullname, incometaxno: @staff.incometaxno, languagespoken: @staff.languagespoken, languagewritten: @staff.languagewritten, majorillness: @staff.majorillness, maritalstatus: @staff.maritalstatus, noofchildren: @staff.noofchildren, nric: @staff.nric, overwrittenleave: @staff.overwrittenleave, overwrittenon: @staff.overwrittenon, password: @staff.password, physicaldisability: @staff.physicaldisability, positionapplied: @staff.positionapplied, previousapplied: @staff.previousapplied, previousdate: @staff.previousdate, previousposition: @staff.previousposition, profession: @staff.profession, race: @staff.race, religion: @staff.religion, salaryexpected: @staff.salaryexpected, salutation: @staff.salutation, servingbond: @staff.servingbond, sex: @staff.sex, spousename: @staff.spousename, spouseoccupation: @staff.spouseoccupation, staffid: @staff.staffid, telephone: @staff.telephone, tier: @staff.tier }
    end

    assert_redirected_to staff_path(assigns(:staff))
  end

  test "should show staff" do
    get :show, id: @staff
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @staff
    assert_response :success
  end

  test "should update staff" do
    patch :update, id: @staff, staff: { address: @staff.address, agerange: @staff.agerange, birthplace: @staff.birthplace, citizenship: @staff.citizenship, colour: @staff.colour, company: @staff.company, dateavailable: @staff.dateavailable, dateemployed: @staff.dateemployed, department: @staff.department, dialect: @staff.dialect, dob: @staff.dob, dobchild: @staff.dobchild, drivinglicenseno: @staff.drivinglicenseno, emergencyaddress: @staff.emergencyaddress, emergencyname: @staff.emergencyname, emergencyrelationship: @staff.emergencyrelationship, emergencytelephone: @staff.emergencytelephone, fullname: @staff.fullname, incometaxno: @staff.incometaxno, languagespoken: @staff.languagespoken, languagewritten: @staff.languagewritten, majorillness: @staff.majorillness, maritalstatus: @staff.maritalstatus, noofchildren: @staff.noofchildren, nric: @staff.nric, overwrittenleave: @staff.overwrittenleave, overwrittenon: @staff.overwrittenon, password: @staff.password, physicaldisability: @staff.physicaldisability, positionapplied: @staff.positionapplied, previousapplied: @staff.previousapplied, previousdate: @staff.previousdate, previousposition: @staff.previousposition, profession: @staff.profession, race: @staff.race, religion: @staff.religion, salaryexpected: @staff.salaryexpected, salutation: @staff.salutation, servingbond: @staff.servingbond, sex: @staff.sex, spousename: @staff.spousename, spouseoccupation: @staff.spouseoccupation, staffid: @staff.staffid, telephone: @staff.telephone, tier: @staff.tier }
    assert_redirected_to staff_path(assigns(:staff))
  end

  test "should destroy staff" do
    assert_difference('Staff.count', -1) do
      delete :destroy, id: @staff
    end

    assert_redirected_to staffs_path
  end
end

json.array!(@staffs) do |staff|
  json.extract! staff, :id, :positionapplied, :salutation, :fullname, :address, :telephone, :dob, :birthplace, :race, :dialect, :nric, :colour, :citizenship, :sex, :religion, :incometaxno, :drivinglicenseno, :maritalstatus, :spousename, :spouseoccupation, :noofchildren, :agerange, :emergencyname, :emergencyrelationship, :emergencyaddress, :emergencytelephone, :servingbond, :salaryexpected, :dateavailable, :previousapplied, :previousdate, :previousposition, :languagespoken, :languagewritten, :physicaldisability, :majorillness, :staffid, :password, :profession, :company, :dateemployed, :dobchild, :department, :tier, :overwrittenleave, :overwrittenon
  json.url staff_url(staff, format: :json)
end

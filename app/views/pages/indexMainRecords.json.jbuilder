json.array!(@mainrecords) do |l|
json.extract! l, :recordId, :companyName, :address, :postalCode, :contactPerson, :position, :hp, :office, :email, :apptBy, :dateAppt, :remarks, :attendedBy, :attendedByGrade, :attendedByRemarks, :closedamount, :invoiceno
end
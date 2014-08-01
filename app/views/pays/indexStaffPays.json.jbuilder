json.array!(@staffPays) do |sp|
json.extract! sp, :staffid, :basic, :attendance, :performance, :commission, :deduction, :employerCpf, :employeeCpf
end
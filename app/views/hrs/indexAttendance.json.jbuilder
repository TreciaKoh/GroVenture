json.array!(@attendances) do |a|
json.extract! a, :staffid, :timein, :leavetype, :date
end
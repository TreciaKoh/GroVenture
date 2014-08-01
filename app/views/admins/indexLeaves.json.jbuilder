json.array!(@leaves) do |l|
json.extract! l, :staffid, :company, :profession, :datestart, :dateend, :total, :reason, :approved, :leavetype, :staff_id, :starttime, :endtime
end
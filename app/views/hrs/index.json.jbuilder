json.array!(@extraleaves) do |e|
json.extract! e, :staffid, :leave, :reason, :validtill
end
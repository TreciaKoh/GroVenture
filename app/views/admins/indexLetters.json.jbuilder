json.array!(@letters) do |l|
json.extract! l, :name, :text
end
json.array!(@letters) do |letter|
  json.extract! letter, :id, :name, :text
  json.url letter_url(letter, format: :json)
end

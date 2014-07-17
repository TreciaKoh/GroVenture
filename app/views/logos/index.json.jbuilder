json.array!(@logos) do |logo|
  json.extract! logo, :id, :name, :supportdoc
  json.url logo_url(logo, format: :json)
end

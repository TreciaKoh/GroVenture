json.array!(@appendixes) do |appendix|
  json.extract! appendix, :id
  json.url appendix_url(appendix, format: :json)
end

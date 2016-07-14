json.array!(@ailments) do |ailment|
  json.extract! ailment, :id, :name
  json.url ailment_url(ailment, format: :json)
end

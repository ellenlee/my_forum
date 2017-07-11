json.data do
  json.array! @posts do |post|
    json.partial! post
  end
end
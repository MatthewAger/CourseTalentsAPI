json.extract! learning_path, :id, :name, :created_at, :updated_at
json.url learning_path_url(learning_path, format: :json)
json.courses do
  json.array! learning_path.courses do |course|
    json.partial! 'courses/course', course:
  end
end

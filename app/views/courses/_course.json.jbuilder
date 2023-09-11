json.extract! course, :id, :title, :description, :created_at, :updated_at
json.author do
  json.extract! course.author, :id, :name, :author?, :talent?, :created_at, :updated_at
end
json.url course_url(course, format: :json)

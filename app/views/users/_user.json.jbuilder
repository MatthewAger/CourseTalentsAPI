json.extract! user, :id, :name, :author?, :talent?, :created_at, :updated_at
json.url user_url(user, format: :json)
json.courses do
  json.author do
    json.array! user.authored_courses do |course|
      json.partial! 'courses/course', course:
    end
  end

  json.talent do
    json.array! user.courses do |course|
      json.partial! 'courses/course', course:
    end
  end
end
json.learning_paths do
  json.array! user.learning_paths do |learning_path|
    json.partial! 'learning_paths/learning_path', learning_path:
  end
end

json.extract! project, :id, :name, :description, :status, :initial_date, :finish, :created_at, :updated_at
json.url project_url(project, format: :json)

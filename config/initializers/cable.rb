if Rails.env.development?
  Rails.application.config.action_cable.allowed_request_origins = ['http://192.168.1.14:8080']
end

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  # localhost

  allow do
    origins 'http://localhost:3000'
    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             credentials: true
  end

  # production

  allow do
    origins 'https://yourdomain.com'
    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             credentials: true
  end
end

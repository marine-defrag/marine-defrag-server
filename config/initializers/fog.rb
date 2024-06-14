if ENV["AWS_ACCESS_KEY_ID"] && ENV["AWS_SECRET_ACCESS_KEY"] && ENV["AWS_ENDPOINT"]
  ::FogStorage = Fog::Storage.new(
    provider: "AWS", # but actually gridscale
    aws_access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
    aws_secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"),
    endpoint: ENV.fetch("AWS_ENDPOINT")
  )
else
  warn "[config/initializers/fog.rb] Missing AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and AWS_ENDPOINT environment variables."
end

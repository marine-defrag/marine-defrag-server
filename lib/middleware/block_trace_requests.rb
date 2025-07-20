# lib/middleware/block_trace_requests.rb
class BlockTraceRequests
  def initialize(app)
    @app = app
  end

  def call(env)
    if env["REQUEST_METHOD"] == "TRACE"
      return [405, { "Content-Type" => "text/plain" }, ["TRACE method not allowed"]]
    end

    @app.call(env)
  end
end

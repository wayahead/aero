module LogRequest
  macro included
    after log_request_path
  end

  private def log_request_path
    Log.dexter.info { {method: request.method, path: request.path} }
    continue
  end
end

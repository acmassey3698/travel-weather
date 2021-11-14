class ErrorSerializer
  def self.bad_request
    {
        message: "Bad request",
        error: "Query missing required information",
    }
  end

  def self.not_found(location)
    {
      message: "No results found",
      error: "No results found for location: #{location}"
    }
  end

  def self.unauthorized
    {
      message: "Unauthorized",
      error: "Invalid credentials provided"
    }
  end
end

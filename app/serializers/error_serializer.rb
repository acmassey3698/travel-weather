class ErrorSerializer
  def self.bad_request
    {
        message: "No forecast found",
        error: "Query missing required information",
    }
  end

  def self.not_found(location)
    {
      message: "No forecast found",
      error: "No forecast found for location: #{location}"
    }
  end
end

class ErrorSerializer
  def self.bad_request
    {
        message: "No results found",
        error: "Query missing required information",
    }
  end

  def self.not_found(location)
    {
      message: "No results found",
      error: "No results found for location: #{location}"
    }
  end
end

class BaseResponse

  attr_accessor :operation_error, :status_code

  def initialize(operation_error: nil, status_code: nil)
    @operation_error = operation_error
    @status_code = status_code
  end

  def success?
    @operation_error.nil?
  end

end
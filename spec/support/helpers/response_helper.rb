module ResponseHelper
  def ok_response(body)
    FakeResponse.new(body, "200")
  end

  class FakeResponse
    attr_reader :body, :code

    def initialize(body, code)
      @body = body
      @code = code
    end
  end
end

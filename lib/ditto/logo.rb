module Ditto
  class Logo
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def brand
      data[:brand]
    end

    def confidence
      data[:match_quality]
    end
  end
end

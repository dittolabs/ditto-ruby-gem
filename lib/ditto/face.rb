module Ditto
  class Face
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def score
      data[:score]
    end
  end
end

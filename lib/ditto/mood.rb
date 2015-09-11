module Ditto
  class Mood
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def score
      data[:mood]
    end
  end
end

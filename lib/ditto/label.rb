module Ditto
  class Label
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def id
      data[:id]
    end

    def label
      data[:label]
    end

    def confidence
      data[:confidence]
    end
  end
end

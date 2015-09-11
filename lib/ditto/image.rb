module Ditto
  class Image
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def url
      response[:url]
    end

    def image_id
      response[:uid]
    end

    def width
      data[:image_width]
    end

    def height
      data[:image_height]
    end

    def faces
      data[:faces].map { |face| Face.new(face) }
    end

    def moods
      data[:moods].map { |mood| Mood.new(mood) }
    end

    def logos
      data[:matches].map { |logo| Logo.new(logo) }
    end

    private

    def data
      response[:data]
    end
  end
end

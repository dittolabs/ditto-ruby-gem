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
      faces_array.map { |face| Face.new(face) }
    end

    def moods
      moods_array.map { |mood| Mood.new(mood) }
    end

    def logos
      data[:matches].map { |logo| Logo.new(logo) }
    end

    private

    def data
      response[:data]
    end

    def faces_array
      data[:faces] || []
    end

    def moods_array
      data[:moods] || []
    end
  end
end

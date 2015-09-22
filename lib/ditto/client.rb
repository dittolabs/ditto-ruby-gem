module Ditto
  class Client
    attr_reader :client_id

    def initialize(client_id)
      @client_id = client_id
    end

    def find(url, id)
      code, body = find_raw(url, id)

      case code
      when "200"
        Image.new(JSON.parse(body, symbolize_names: true))
      when "408"
        raise ImageTimeoutError
      when "415"
        raise InvalidImageError
      end
    end

    def find_raw(url, id)
      response = Net::HTTP.get_response(find_uri(url, id))
      [response.code, response.body]
    end

    def find_uri(url, id)
      URI::HTTP.build(
        host: "ondemand-p02-api.ditto.us.com",
        path: "/v1/find",
        query: encoded(image_match_params(url, id)))
    end

    private

    def encoded(params)
      URI.encode_www_form(params).gsub("+", "%20")
    end

    def image_match_params(url, id)
      { client_id: client_id, url: url, uid: id }
    end
  end
end

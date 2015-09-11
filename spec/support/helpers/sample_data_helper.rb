require "json"

module SampleDataHelper
  def timeout_image(url, uid)
    error_image(url, uid, "Image Retrieve Timeout")
  end

  def invalid_image(url, uid)
    error_image(url, uid, "Invalid image")
  end

  def error_image(url, uid, status)
    {
      status: "Invalid image",
      url: url,
      uid: uid,
      data: {}
    }.to_json
  end

  def blank_image(url, uid)
    {
      status: "OK",
      url: url,
      uid: uid,
      data: {
        image_width: 800,
        image_height: 640,
        matches: []
      },
    }.to_json
  end

  def sample_image(url, uid)
    {
      status: "OK",
      data: {
        moods: [
          {
            face_rect: [[468, 338], [557, 338], [468, 427], [557, 427]],
            mood: 0.534081
          },
          {
            face_rect: [[308, 276], [404, 276], [308, 372], [404, 372]],
            mood: 6.268349
          }
        ],
        average_mood: 3.401215,
        nmoods: 2,
        faces: [
          {
            score: 56,
            face_rect: [[472, 323], [558, 323], [472, 439], [558, 439]]
          },
          {
            score: 44,
            face_rect: [[316, 65], [394, 65], [316, 169], [394, 169]]
          },
          {
            score: 40,
            face_rect: [[315, 291], [385, 291], [315, 385], [385, 385]]
          }
        ],
        nfaces: 3,
        matches: [
          {
            logo_rect: [[264, 413], [264, 496], [393, 496], [410, 445]],
            brand: "Coca_Cola",
            match_quality: "High"
          },
          {
            logo_rect: [[16, 356], [69, 444], [164, 431], [282, 351]],
            brand: "Boston_Red_Sox",
            match_quality: "Medium"
          }
        ],
        image_height: 640,
        image_width: 800
      },
      uid: uid,
      url: url
    }.to_json
  end
end

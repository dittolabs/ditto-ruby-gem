require "ditto"

RSpec.describe Ditto::Client do
  include ResponseHelper
  include SampleDataHelper

  let(:client_id) { "abc123" }
  let(:client) { Ditto::Client.new(client_id) }
  let(:url) { "http://www.example.com/foo.jpg" }
  let(:image_id) { "1234" }

  describe "#find" do
    let(:response) { ok_response(response_body) }

    subject(:image) { client.find(url, image_id) }

    before(:each) do
      expect(Net::HTTP).to receive(:get_response).and_return(response)
    end

    context "when an image is invalid" do
      let(:response) { invalid_response(invalid_image(url, image_id)) }

      it "raises an error" do
        expect { client.find(url, image_id) }.to(
          raise_error(Ditto::InvalidImageError))
      end
    end

    context "when an image times out" do
      let(:response) { timeout_response(timeout_image(url, image_id)) }

      it "raises an error" do
        expect { client.find(url, image_id) }.to(
          raise_error(Ditto::ImageTimeoutError))
      end
    end

    context "when an image has no matches" do
      let(:response_body) { blank_image(url, image_id) }

      it { is_expected.to have_attributes(url: url, image_id: image_id) }
      it { is_expected.to have_attributes(width: 800, height: 640) }
      it { expect(image.faces).to be_empty }
      it { expect(image.moods).to be_empty }
      it { expect(image.logos).to be_empty }
      it { expect(image.labels).to be_empty }
    end

    context "when an image has logos and faces and labels" do
      let(:response_body) { sample_image(url, image_id) }

      it { is_expected.to have_attributes(url: url, image_id: image_id) }
      it { is_expected.to have_attributes(width: 800, height: 640) }

      it "has any faces detected" do
        expect(image.faces).to(contain_exactly(
            an_object_having_attributes(score: 56),
            an_object_having_attributes(score: 44),
            an_object_having_attributes(score: 40)))
      end

      it "has any moods detected" do
        expect(image.moods).to(contain_exactly(
            an_object_having_attributes(score: 0.534081),
            an_object_having_attributes(score: 6.268349)))
      end

      it "has any logos detected" do
        expect(image.logos).to(contain_exactly(
            an_object_having_attributes(
              brand: "Coca_Cola", confidence: "High"),
            an_object_having_attributes(
              brand: "Boston_Red_Sox", confidence: "Medium")))
      end

      it "has any labels detected" do
        expect(image.labels).to(contain_exactly(
          an_object_having_attributes(
            label: "coffee cup", confidence: 0.91216)))
      end

      it "has a confidence threshold" do
        expect(image.label_confidence_threshold).to eq(0.5)
      end
    end
  end

  describe "#find_raw" do
    it "returns the response code and body without parsing" do
      response_body = sample_image(url, image_id)
      response = ok_response(response_body)
      expect(Net::HTTP).to receive(:get_response).and_return(response)

      expect(client.find_raw(url, image_id)).to eq(["200", response_body])
    end
  end

  describe "#find_uri" do
    it "properly encodes urls" do
      expect(client.find_uri("http://a.bc/d.png", "123").to_s).to(
        include("url=http%3A%2F%2Fa.bc%2Fd.png"))
    end

    it "properly encodes ids" do
      expect(client.find_uri("http://a.bc/d.png", "!$&= +?").to_s).to(
        include("uid=%21%24%26%3D%20%2B%3F"))
    end
  end
end

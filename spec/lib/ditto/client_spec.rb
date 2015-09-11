require "ditto"

RSpec.describe Ditto::Client do
  include ResponseHelper
  include SampleDataHelper

  let(:client_id) { "abc123" }
  let(:client) { Ditto::Client.new(client_id) }

  describe "#find" do
    let(:url) { "http://www.example.com/foo.jpg" }
    let(:image_id) { "1234" }

    subject(:image) { client.find(url, image_id) }

    before(:each) do
      expect(Net::HTTP).to receive(:get_response)
        .and_return(ok_response(response_body))
    end

    context "when an image has no matches" do
      let(:response_body) { blank_image(url, image_id) }

      it { is_expected.to have_attributes(url: url, image_id: image_id) }
      it { is_expected.to have_attributes(width: 800, height: 640) }
      it { expect(image.faces).to be_empty }
      it { expect(image.moods).to be_empty }
      it { expect(image.logos).to be_empty }
    end

    context "when an image has logos and faces" do
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

require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
  let(:topic) { Topic.create!(name: name, description: description) }
  let(:post) { topic.posts.create!(title: title, body: body) }
  let (:sponsored_post) { SponsoredPost.create! }

  describe "attributes" do
    it "should respond to title" do
      expect(sponsored_post).to respond_to(:title)
    end

    it "should respond to body" do
      expect(sponsored_post).to respond_to(:body)
    end

    it "should respond to price" do
      expect(sponsored_post).to respond_to(:price)
    end
  end
end

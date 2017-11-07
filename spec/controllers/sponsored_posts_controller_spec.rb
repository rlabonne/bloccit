require 'rails_helper'
include RandomData

RSpec.describe SponsoredPostsController, type: :controller do
  let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }

  let(:my_spost) { my_topic.sponsoredposts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 88) }

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { topic_id: my_topic.id, id: my_spost.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: { topic_id: my_topic.id, id: my_spost.id }
      expect(response).to render_template :show
    end

    it "assigns my_spost to @sponsoredpost" do
      get :show, params: { topic_id: my_topic.id, id: my_spost.id }
      expect(assigns(:sponsoredpost)).to eq(my_spost)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: { topic_id: my_topic.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, params: { topic_id: my_topic.id }
      expect(response).to render_template :new
    end

    it "instantiates @sponsoredpost" do
      get :new, params: { topic_id: my_topic.id }
      expect(assigns(:sponsoredpost)).not_to be_nil
    end
  end

  describe "SponsoredPost create" do
    it "increases the number of SponsoredPost by 1" do
      expect{ sponsoredpost :create, params: { topic_id: my_topic.id, sponsoredpost: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 88 } } }.to change(SponsoredPost,:count).by(1)
    end

    it "assigns the new post to @post" do
      post :create, params: { topic_id: my_topic.id, sponsoredpost: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 88 } }
      expect(assigns(:sponsoredpost)).to eq SponsoredPost.last
    end

    it "redirects to the new post" do
      post :create, params: { topic_id: my_topic.id, sponsoredpost: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 88 } }
      expect(response).to redirect_to [my_topic, SponsoredPost.last]
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { topic_id: my_topic.id, id: my_spost.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, params: { topic_id: my_topic.id, id: my_spost.id }
      expect(response).to render_template :edit
    end

    it "assigns post to be updated to @post" do
      get :edit, params: { topic_id: my_topic.id, id: my_spost.id }

      sponsoredpost_instance = assigns(:sponsoredpost)

      expect(sponsoredpost_instance.id).to eq my_spost.id
      expect(sponsoredpost_instance.title).to eq my_spost.title
      expect(sponsoredpost_instance.body).to eq my_spost.body
      expect(sponsoredpost_instance.price).to eq my_spost.price
    end
  end

  describe "PUT update" do
    it "updates sponsoredpost with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = 88

      put :update, params: { topic_id: my_topic.id, id: my_spost.id, sponsoredpost: {title: new_title, body: new_body } }

      updated_sponsoredpost = assigns(:sponsoredpost)
      expect(updated_sponsoredpost.id).to eq my_spost.id
      expect(updated_sponsoredpost.title).to eq new_title
      expect(updated_sponsoredpost.body).to eq new_body
      expect(updated_sponsoredpost.price).to eq new_price
    end

    it "redirects to the updated sponsoredpost" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_price = 88

      put :update, params: { topic_id: my_topic.id, id: my_spost.id, post: {title: new_title, body: new_body } }
      expect(response).to redirect_to [my_topic, my_post]
    end
  end

  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, params: { topic_id: my_topic.id, id: my_spost.id }
      count = SponsoredPost.where({id: my_spost.id}).size
      expect(count).to eq 0
    end

    it "redirects to topic show" do
      delete :destroy, params: { topic_id: my_topic.id, id: my_spost.id }
      expect(response).to redirect_to my_topic
    end
  end
end

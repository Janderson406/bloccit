require 'rails_helper'

RSpec.describe AdvertisementsController, type: :controller do
let(:advertisement) {Advertisement.create!(title: "New Advertisement Title", copy: "New Advertisement Body", price: 50) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [advertisement] to @advertisements" do
      get :index
      expect(assigns(:advertisements)).to eq([advertisement])
    end
  end

##SHOW AD
  describe "GET #show" do
    it "returns http success" do
      get :show, {id: advertisement.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: advertisement.id}
      expect(response).to render_template :show
    end

    it "assigns my_advertisement to @advertisement" do
      get :show, {id: advertisement.id}
      expect(assigns(:advertisement)).to eq(advertisement)
    end
  end

##CREATING ADS
  describe "GET new" do
       it "returns http success" do
         get :new
         expect(response).to have_http_status(:success)
       end

       it "renders the #new view" do
         get :new
         expect(response).to render_template :new
       end

       it "instantiates @advertisement" do
         get :new
         expect(assigns(:advertisement)).not_to be_nil
       end
     end


     describe "POST create" do
       it "increases the number of Advertisement by 1" do
         expect{post :create, advertisement: {title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: RandomData.random_sentence}}.to change(Advertisement,:count).by(1)
       end

       it "assigns the new advertisement to @advertisement" do
         post :create, advertisement: {title: RandomData.random_sentence, copy: RandomData.random_paragraph, price: RandomData.random_sentence}
         expect(assigns(:advertisement)).to eq Advertisement.last
       end

       it "redirects to the new advertisement" do
         post :create, advertisement: {title: RandomData.random_sentence, copy: RandomData.random_paragraph, }
         expect(response).to redirect_to Advertisement.last
       end
     end



end

require 'rails_helper'
require_relative "../support/controller_macros"
require_relative "../support/devise"

RSpec.describe OrdersController, type: :controller do
  login_requester

  context "from login requester" do
    it "should get index" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
    # note the fact that you should remove the "validate_session" parameter if this was a scaffold-generated controller  end
  
  describe 'GET #index' do
    it 'should sucess and render index' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
    
    it 'should have empty array of orders' do
      get :index
      expect(assigns(:orders)).to be_blank
    end

    it 'should have one order' do
      create(:order)
      get :index
      expect(assigns(:orders)).to be_present
    end
  end

  context 'GET #show' do
      let(:order) { FactoryBot.create(:order) }
      it "should redirect to login page" do
        get :show, params: { id: order.id }
        expect(assigns(:order)).to be_a(Order)
        expect(response).to render_template(:show)
           
      end
  end

  context 'GET #new' do
    it 'should success and render to new page' do
      get :new
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end

    it 'should have new order' do
      get :new
      expect(assigns(:order)).to be_a_new(Order)
    end
  end

  context'Post #create' do
    it 'should create order' do
      post :create, params: { order: { address: 'address' } }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(assigns(:order))
    end
    it 'should not create order' do
      post :create, params: { order: { address: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:new)
    end
  end

  context 'GET #edit' do
    let(:order) { FactoryBot.create(:order) }
    it 'should success and render to edit page' do
      get :edit, params: { id: order.id }
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:edit)
    end

    it 'should have order' do
      get :edit, params: { id: order.id }
      expect(assigns(:order)).to be_a(Order)
    end
  end

  context 'PUT #update' do
    let(:order) { FactoryBot.create(:order) }
    it 'should update order' do
      put :update, params: { id: order.id, order: { address: 'new address' } }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(assigns(:order))
    end

    it 'should not update order' do
      put :update, params: { id: order.id, order: { address: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template(:edit)
    end
  end

  context 'DELETE #destroy' do
    let(:order) { FactoryBot.create(:order) }
    it 'should destroy order' do
      delete :destroy, params: { id: order.id }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(orders_path)
    end
  end
end
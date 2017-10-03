require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) { create(:user, email: 'user@example.com', password: '123456') }

  describe 'GET #new' do
    it 'renders new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      before(:each) do
        post :create, params: { email: 'user@example.com', password: '123456' }
      end

      it 'creates new session' do
        expect(session[:user_id]).to eq user.id
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
      before(:each) do
        post :create, params: { email: 'user@example.com', password: '654321' }
      end

      it 're-render new template' do
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:each) do
      session[:user_id] = user.id
      delete :destroy
    end

    it 'destroys the session' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to root path' do
      expect(response).to redirect_to root_path
    end
  end
end

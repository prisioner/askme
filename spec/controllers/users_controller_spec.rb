require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user, username: 'username') }
  let(:user2) { create(:user, username: 'another') }
  let(:questions) { create_list(:question, 3, user: user) }

  describe 'GET #index' do
    let!(:users) { create_list(:user, 3) }
    let!(:question) { create(:question, user: users.first) }
    let(:tags) { question.tags }

    before(:each) { get :index }

    it 'renders #index template' do
      expect(response).to render_template :index
    end

    it 'assigns users to @users' do
      expect(assigns(:users)).to eq users
    end

    it 'assigns tags to @tags' do
      expect(assigns(:tags)).to eq tags
    end
  end

  describe 'GET #show' do
    before(:each) do
      get :show, params: { id: user }
    end

    it 'render #show template' do
      expect(response).to render_template :show
    end

    it 'assigns user to @user' do
      expect(assigns(:user)).to eq user
    end
  end

  describe 'GET #new' do
    it 'renders #new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    context 'user tries to edit own account' do
      before(:each) do
        session[:user_id] = user.id
      end

      it 'renders #edit template' do
        get :edit, params: { id: user }
        expect(response).to render_template :edit
      end
    end

    context 'user tries to edit account of another user' do
      it 'redirects to root_path' do
        get :edit, params: { id: user }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      it 'add user to database' do
        expect { post :create, params: { user: attributes_for(:user, password: '12345678') } }.to change(User, :count).by(1)
      end

      it 'redirects to root path' do
        post :create, params: { user: attributes_for(:user, password: '12345678') }
        expect(response).to redirect_to root_path
      end
    end

    context 'invalid attributes' do
      it 'do not add user to database' do
        expect { post :create, params: { user: attributes_for(:invalid_user) } }.to_not change(User, :count)
      end

      it 're-renders #new view' do
        post :create, params: { user: attributes_for(:invalid_user) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'user tries to update self account' do
      before do
        session[:user_id] = user.id
      end

      context 'valid attributes' do
        it 'update user attributes' do
          patch :update, params: { id: user.id, user: { username: 'new_username' } }
          user.reload

          expect(user.username).to eq 'new_username'
        end

        it 'redirects to user' do
          patch :update, params: { id: user.id, user: { username: 'new_username' } }

          expect(response).to redirect_to user_path(user)
        end
      end

      context 'invalid attributes' do
        it 're-renders #edit view' do
          patch :update, params: { id: user.id, user: { username: nil } }

          expect(response).to render_template :edit
        end

        it 'do not update user attributes' do
          patch :update, params: { id: user.id, user: { username: nil } }
          user.reload

          expect(user.username).to eq 'username'
        end
      end
    end

    context 'user tries to update another account' do
      before do
        session[:user_id] = user2.id
      end

      it 'do not update user attributes' do
        patch :update, params: { id: user.id, user: { username: 'new_username' } }
        user.reload

        expect(user.username).to eq 'username'
      end

      it 'redirects to root path' do
        patch :update, params: { id: user.id, user: { username: 'new_username' } }

        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'user tries to delete own account' do
      before do
        session[:user_id] = user.id
      end

      it 'delete user account' do
        expect { delete :destroy, params: { id: user.id } }.to change(User, :count).by(-1)
      end
    end

    context 'user tries to delete another account' do
      before do
        session[:user_id] = user2.id
      end

      it 'do not delete user account' do
        user

        expect { delete :destroy, params: { id: user.id } }.to_not change(User, :count)
      end
    end
  end
end

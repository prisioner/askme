require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:own_question) { create(:question, user: user, text: 'question text', answer: nil) }
  let!(:question) { create(:question, text: 'question text', answer: nil) }

  describe 'GET #edit' do
    before(:each) do
      session[:user_id] = user.id
    end

    context 'user is question owner' do
      before do
        get :edit, params: { id: own_question }
      end

      it 'renders #edit template' do
        expect(response).to render_template :edit
      end
    end

    context 'user is not question owner' do
      before do
        get :edit, params: { id: question }
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST #create' do
    context 'valid attributes' do
      let!(:asked_user) { create(:user) }

      it 'add question to database and assigns to asked user' do
        expect { post :create, params: { question: attributes_for(:question, user_id: asked_user.id) } }.to change(asked_user.questions, :count).by(1)
      end

      it 'redirects to user path' do
        post :create, params: { question: attributes_for(:question, user_id: asked_user.id) }

        expect(response).to redirect_to user_path(asked_user)
      end

      context 'registered user creates question' do
        before do
          session[:user_id] = user.id
        end

        it 'assigns current user as question author' do
          post :create, params: { question: attributes_for(:question) }

          expect(assigns(:question).author).to eq user
        end
      end

      context 'anon user creates question' do
        it 'does not assign author to question' do
          post :create, params: { question: attributes_for(:question) }

          expect(assigns(:question).author).to be_nil
        end
      end
    end

    context 'invalid attributes' do
      it 'does not save questions in database' do
        expect { post :create, params: { question: attributes_for(:invalid_question) } }.not_to change(Question, :count)
      end

      it 'render #edit template' do
        post :create, params: { question: attributes_for(:invalid_question) }

        expect(response).to render_template :edit
      end
    end
  end

  describe 'PATCH #update' do
    context 'question owner tries to update it' do
      before(:each) do
        session[:user_id] = user.id
        patch :update, params: { id: own_question, question: { user_id: user, text: 'new text', answer: 'my answer' } }
      end

      it 'update question attributes' do
        own_question.reload

        expect(own_question.text).to eq 'new text'
        expect(own_question.answer).to eq 'my answer'
      end

      it 'redirects to user path' do
        expect(response).to redirect_to user_path(user)
      end
    end

    context 'another user tries to update question' do
      before(:each) do
        patch :update, params: { id: question, question: { text: 'new text', answer: 'my answer' } }
      end

      it 'does not update question attributes' do
        question.reload

        expect(question.text).to eq 'question text'
        expect(question.answer).to be_nil
      end

      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'user tries to delete own question' do
      before(:each) do
        session[:user_id] = user.id
      end

      it 'deletes question from database' do
        expect { delete :destroy, params: { id: own_question } }.to change(Question, :count).by(-1)
      end

      it 'redirects to user path' do
        delete :destroy, params: { id: own_question }

        expect(response).to redirect_to user_path(user)
      end
    end

    context 'user tries to delete another user question' do
      it 'does not delete questions from database' do
        expect { delete :destroy, params: { id: question } }.to_not change(Question, :count)
      end

      it 'redirects to root path' do
        delete :destroy, params: { id: question }

        expect(response).to redirect_to root_path
      end
    end
  end
end

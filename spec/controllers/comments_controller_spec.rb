require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'GET #index' do
    before :each do
      @comment = FactoryGirl.create(:comment, user: @user, project: @project)
      get :index
    end
    it 'returns success' do
      expect(response).to be_success
    end
    it 'assigns correctly comments' do
      expect(assigns(:comments)).to eq([@comment])
    end
  end

  describe 'GET #show' do
    before :each do
      @comment = FactoryGirl.create(:comment, user: @user, project: @project)
      get :show, id: @comment
    end

    it 'return success' do
      expect(response).to be_success
    end

    it 'assigns the correct comment' do
      expect(assigns(:comment)).to eq(@comment)
    end
  end

  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before :each do
      @user = FactoryGirl.create(:user)
      @project = FactoryGirl.create(:project, user: @user)
      @commenter = FactoryGirl.create(:user, email: "marcle@gmail.com")
    end
    context 'with valid attributes' do
      before :each do
        @comment = FactoryGirl.attributes_for(:comment, title: "Comment", body:"Great", project: @project, user: @commenter)
      end

      it 'creates a new comment' do
        expect{
          post :create, { :comment => @comment }
        }.to change(Comment, :count).by(1)
      end

      it 'assigns new comment correctly' do
        post :create, { :comment => @comment }
        expect(assigns(:comment)).to be_a(Comment)
      end

      it 'persists new comment' do
        post :create, { :comment => @comment }
        expect(assigns(:comment)).to be_persisted
      end

      it 'redirects to new comment' do
        post :create, { :comment => @comment }
        expect(response).to redirect_to(Comment.last)
      end
    end

    context 'with invalid params' do
      before :each do
        @comment = FactoryGirl.attributes_for(:comment, title: nil, project: @project, user: @commenter)
      end

      it 'does not save the comment' do
        expect{
          post :create, { :comment => @comment}
        }.not_to change(Comment, :count)
      end

      it 're-renders the :new template' do
        post :create, { :comment => @comment }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before :each do
      @user = FactoryGirl.create(:user)
      @project = FactoryGirl.create(:project, user: @user)
      @commenter = FactoryGirl.create(:user, email: "marcle@gmail.com")
    end
    context 'with valid params' do
      before :each do
        @comment = FactoryGirl.create(:comment, title: "First", user: @commenter, project: @project)
        put :update, id: @comment, comment: FactoryGirl.attributes_for(:comment, title:"Changed")
      end

      it 'locates the corret comment' do
        expect(assigns(:comment)).to eq(@comment)
      end

      it 'changes comments attributes' do
        @comment.reload
        expect(@comment.title).to eq("Changed")
      end

      it 'redirects to the updated comment' do
        expect(response).to redirect_to @comment
      end
    end

    context 'with invalid params' do
      before :each do
        @comment = FactoryGirl.create(:comment, title: "First", user: @commenter, project: @project)
        put :update, id: @comment, comment: FactoryGirl.attributes_for(:comment, title: nil)
      end

      it 'locates the requested comment' do
        expect(assigns(:comment)).to eq(@comment)
      end

      it 'does not update the comment' do
        @comment.reload
        expect(@comment.title).to eq("First")
      end

      it 're-renders the :edit template' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @comment = FactoryGirl.create(:comment, user: @commenter, project: @project)
      delete :destroy, id: @comment
    end

    it 'assigns the correct comment' do
      expect(assigns(:comment)).to eq(@comment)
    end

    it 'deletes the comment' do
      @comment = FactoryGirl.create(:comment, user: @commenter, project: @project)
      expect{
        delete :destroy, id: @comment
      }.to change(Comment, :count).by(-1)
    end

    it 'redirects to comments#index' do
      expect(response).to redirect_to comments_path
    end
  end
end

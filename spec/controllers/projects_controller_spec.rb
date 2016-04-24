require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'GET #index' do
    before :each do
      @current_user = FactoryGirl.create(:user, email: "test2@tes.com")
      @project = FactoryGirl.create(:project, user: FactoryGirl.create(:user))
      get :index
    end
    it 'return success' do
      expect(response).to be_success
    end
    it 'assigns correctly the projects' do
      expect(assigns(:projects)).to eq([@project])
    end
  end

  describe 'GET #show' do
    before :each do
      @project = FactoryGirl.create(:project, user: FactoryGirl.create(:user))
      get :show, id: @project.id
    end

    it 'return success' do
      expect(response).to be_success
    end
    it 'assigns the correct project' do
      expect(assigns(:project)).to eq(@project)
    end
  end

  describe 'GET #new' do
    it 'renders the :new template' do
      get :new
      expect(response).to render_template(:new)
    end
    it 'assigns a empty object to @project' do
      get :new
      expect(assigns(:project).id).to be_nil
    end
  end

  describe 'POST #create' do
    context 'with valid paramas' do
      before :each do
        @category = FactoryGirl.create(:category)
        @user = FactoryGirl.create(:user)
        @project = FactoryGirl.attributes_for(:project, user_id: @user,  category_id: @category )
      end
      it 'creates a new project' do
        expect {
          post :create, { :project => @project  }
        }.to change(Project, :count).by(1)
      end
      it 'assigns new project correctly' do
        post :create, { :project => @project }
        expect(assigns(:project)).to be_a(Project)
      end
      it 'persists the new project' do
        post :create, { :project => @project }
        expect(assigns(:project)).to be_persisted
      end
      it 'redirects to the project page' do
        post :create, { :project => @project }
        expect(response).to redirect_to(Project.last)
      end
    end

    context 'with invalid params' do
      before :each do
        @project = FactoryGirl.attributes_for(:project)
      end
      it 'does not save the project' do
        expect{
          post :create, { :project => @project}
        }.not_to change(Project, :count)
      end
      it 're-renders the :new template' do
        post :create, { :project => @project }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      before :each do
        @user = FactoryGirl.create(:user)
        @project = FactoryGirl.create(:project, name: "Castle", user: @user)
      end

      it 'locates the request project' do
        put :update, id: @project, project: FactoryGirl.attributes_for(:project)
        expect(assigns(:project)).to eq(@project)
      end
      it 'changes project attributes' do
        put :update, id: @project, project: FactoryGirl.attributes_for(:project, name: "Bali")
        @project.reload
        expect(@project.name).to eq("Bali")
      end
      it 'redirects to the updated project' do
        put :update, id: @project, project: FactoryGirl.attributes_for(:project, name: "Bali")
        expect(response).to redirect_to @project
      end
    end

    context 'with invalid attributes' do
      before :each do
        @user = FactoryGirl.create(:user)
        @project = FactoryGirl.create(:project, name: "Castle", user: @user)
      end

      it 'locates the requested project' do
        put :update, id: @project, project: FactoryGirl.attributes_for(:project)
        expect(assigns(:project)).to eq(@project)
      end
      it 'does not change project attributes' do
        put :update, id: @project, project: FactoryGirl.attributes_for(:project, name: nil)
        @project.reload
        expect(@project.name).to eq("Castle")
      end
      it 're-renders the :edit template' do
        put :update, id: @project, project: FactoryGirl.attributes_for(:project, name: nil)
        expect(response).to render_template :edit
      end
    end
   end

  describe 'DELETE #destroy' do
    before :each do
      @user = FactoryGirl.create(:user)
      @project = FactoryGirl.create(:project, user: @user)
    end

    it 'assigns the correct project' do
      delete :destroy, id: @project
      expect(assigns(:project)).to eq(@project)
    end
    it 'deletes the project' do
      expect{
        delete :destroy, id: @project
      }.to change(Project, :count).by(-1)
    end
    it 'redirects to projects#index' do
      delete :destroy, id: @project
      expect(response).to redirect_to projects_path
    end
  end
end

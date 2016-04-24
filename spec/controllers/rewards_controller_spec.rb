require 'rails_helper'

RSpec.describe RewardsController, type: :controller do
  describe 'GET #index' do
    before :each do
      @project = FactoryGirl.create(:project, user: FactoryGirl.create(:user))
      @reward = FactoryGirl.create(:reward, project: @project)
      get :index
    end

    it 'returns success' do
      expect(response).to be_success
    end

    it 'assigns correctly @rewards' do
      expect(assigns(:rewards)).to eq([@reward])
    end
  end

  describe 'GET #show' do
    before :each do
      @project = FactoryGirl.create(:project, user: FactoryGirl.create(:user))
      @reward = FactoryGirl.create(:reward, project: @project)
      get :show, id: @reward
    end

    it 'return success' do
      expect(response).to be_success
    end

    it 'assigns the correct reward' do
      expect(assigns(:reward)).to eq(@reward)
    end
  end

  describe 'POST #create' do
    before :each do
      @project = FactoryGirl.create(:project, user: FactoryGirl.create(:user))
    end

    context 'with valid attributes' do
      before :each do
        @reward = FactoryGirl.attributes_for(:reward, project_id: @project)
      end

      it 'creates a new reward' do
        expect{
          post :create, { :reward => @reward}
        }.to change(Reward, :count).by(1)
      end

      it 'assigns correctly the new reward' do
        post :create, { :reward => @reward }
        expect(assigns(:reward)).to be_a(Reward)
      end

      it 'persists the new reward' do
        post :create, { :reward => @reward }
        expect(assigns(:reward)).to be_persisted
      end

      it 'redirects to the new reward' do
        post :create, { :reward => @reward }
        expect(response).to redirect_to(Reward.last)
      end
    end

    context 'with invalid params' do
      before :each do
        @reward = FactoryGirl.attributes_for(:reward, project: @project, value: nil)
      end

      it 'does not save the reward' do
        expect{
          post :create, { :reward => @reward }
        }.not_to change(Reward, :count)
      end

      it 're-renders the :new template' do
        post :create, { :reward => @reward }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    before :each do
      @project = FactoryGirl.create(:project, user: FactoryGirl.create(:user))
      @reward = FactoryGirl.create(:reward, name: "Castle", project: @project)
    end

    context 'with valid params' do
      before :each do
        put :update, id: @reward, reward: FactoryGirl.attributes_for(:reward, name:"Cave")
      end

      it 'locates the requested reward' do
        expect(assigns(:reward)).to eq(@reward)
      end

      it 'changes reward attributes' do
        @reward.reload
        expect(assigns(:reward).name).to eq("Cave")
      end

      it 'redirect to the updated reward' do
        expect(response).to redirect_to @reward
      end
    end

    context 'with invalid params' do
      before :each do
        put :update, id: @reward, reward: FactoryGirl.attributes_for(:reward, name: "Jungle", value: nil)
      end

      it 'assigns the correct reward' do
        expect(assigns(:reward)).to eq(@reward)
      end

      it 'does not update the reward' do
        @reward.reload
        expect(@reward.name).to eq("Castle")
      end

      it 're-renders the :edit template' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @project = FactoryGirl.create(:project, user: FactoryGirl.create(:user))
      @reward = FactoryGirl.create(:reward, project: @project)
      delete :destroy, id: @reward
    end

    it 'assigns the correct reward' do
      expect(assigns(:reward)).to eq(@reward)
    end

    it 'destroys the reward' do
      @reward = FactoryGirl.create(:reward, project: @project)
      expect{
        delete :destroy, id: @reward
      }.to change(Reward, :count).by(-1)
    end

    it 'redirects to rewards#index' do
      expect(response).to redirect_to rewards_path
    end
  end
end

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe 'GET #index' do
    before :each do
      @category = FactoryGirl.create(:category)
      get :index
    end

    it 'return success' do
      expect(response).to be_success
    end
    it 'assigns correctly categories' do
      expect(assigns(:categories)).to eq([@category])
    end
  end

  describe 'GET #show' do
    before :each do
      @category = FactoryGirl.create(:category)
      get :show, id: @category
    end

    it 'returns success' do
      expect(response).to be_success
    end

    it 'assigns the correct category' do
      expect(assigns(:category)).to eq(@category)
    end
  end

  describe 'GET #new' do
    before :each do
      get :new
    end

    it 'renders the :new template' do
      expect(response).to render_template :new
    end

    it 'assigns an empty object to @category' do
      expect(assigns(:category).id).to be_nil
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      before :each do
        @category = FactoryGirl.attributes_for(:category)
      end

      it 'creates a new category' do
        expect {
          post :create, { :category =>  @category }
        }.to change(Category, :count).by(1)
      end

      it 'assigns new category correctly' do
        post :create, { :category => @category }
        expect(assigns(:category)).to be_a(Category)
      end

      it 'persists the new category' do
        post :create, { :category => @category }
        expect(assigns(:category)).to be_persisted
      end

      it 'redirects to the category' do
        post :create, { :category => @category }
        expect(response).to redirect_to(Category.last)
      end
    end

    context 'with invalid params' do
      before :each do
        @category = FactoryGirl.attributes_for(:category, name: nil)
      end

      it 'does not save the category' do
        expect{
          post :create, {:category => @category }
        }.not_to change(Category, :count)
      end

      it 're-render the :new template' do
        post :create, { :category => @category }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      before :each do
        @category = FactoryGirl.create(:category, name: "Castle")
        put :update, id: @category, category: FactoryGirl.attributes_for(:category, name: "Cave")
      end

      it 'locates the requested category' do
        expect(assigns(:category)).to eq(@category)
      end

      it 'changes category attributes' do
        @category.reload
        expect(@category.name).to eq("Cave")
      end

      it 'redirects to the updated category' do
        expect(response).to redirect_to @category
      end
    end

    context 'with invalid attributes' do
      before :each do
        @category = FactoryGirl.create(:category, name: "Castle")
        put :update, id: @category, category: FactoryGirl.attributes_for(:category, name: nil)
      end

      it 'locates the requested category' do
        expect(assigns(:category)).to eq(@category)
      end

      it 'does not update the category' do
        @category.reload
        expect(@category.name).to eq("Castle")
      end

      it 're-renders the :edit template' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @category = FactoryGirl.create(:category)
      delete :destroy, id: @category
    end

    it 'assigns the correct category' do
      expect(assigns(:category)).to eq(@category)
    end

    it 'deletes the category' do
      @category = FactoryGirl.create(:category)
      expect{
        delete :destroy, id: @category
      }.to change(Category, :count).by(-1)
    end

    it 'redirects to categories#index' do
      expect(response).to redirect_to categories_path
    end
  end
end

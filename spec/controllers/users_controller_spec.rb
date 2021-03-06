require 'rails_helper'

describe UsersController do
  let (:rash) { FactoryGirl.create(:ailment, name: "Rash") }

  let(:valid_attributes) { attributes_for :user, ailment_ids: [rash.id] }

  let(:invalid_attributes) { attributes_for :user, email: 'invalid_email' }

  describe "as a patient" do
    before do
      @patient = FactoryGirl.create(:patient)
      sign_in @patient
    end

    context "GET #index" do
      it "assigns all users as @users" do
        doctor = FactoryGirl.create(:ny_doctor)
        get :index, {}
        expect(assigns(:users)).to eq([doctor])
      end
    end

    context "GET #show" do
      it "assigns the requested user as @user" do
        get :show, {:id => @patient.to_param}
        expect(assigns(:user)).to eq(@patient)
      end
    end
  end

  describe "as an admin" do
    before { sign_in FactoryGirl.create(:admin)}

    describe "GET #edit" do
      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        get :edit, {:id => user.to_param}
        expect(assigns(:user)).to eq(user)
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { { first_name: 'John', last_name: 'Doe' } }

        it "updates the requested user" do
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => new_attributes}
          user.reload
          expect(user.first_name).to eq 'John'
          expect(user.last_name).to eq 'Doe'
        end

        it "assigns the requested user as @user" do
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => valid_attributes}
          expect(assigns(:user)).to eq(user)
        end

        it "changes specialty" do
          fever = FactoryGirl.create(:ailment, name: "fever")
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => valid_attributes.merge(ailment_ids: [fever.id])}
          user.reload
          expect(user.ailments).to include fever
          expect(user.ailments).not_to include rash
        end


        it "redirects to the user" do
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => valid_attributes}
          expect(response).to redirect_to(user)
        end
      end

      context "with invalid params" do
        it "assigns the user as @user" do
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => invalid_attributes}
          expect(assigns(:user)).to eq(user)
        end

        it "re-renders the 'edit' template" do
          user = User.create! valid_attributes
          put :update, {:id => user.to_param, :user => invalid_attributes}
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested user" do
        user = User.create! valid_attributes
        expect {
          delete :destroy, {:id => user.to_param}
        }.to change(User, :count).by(-1)
      end

      it "redirects to the users list" do
        user = User.create! valid_attributes
        delete :destroy, {:id => user.to_param}
        expect(response).to redirect_to(users_url)
      end
    end

    describe "Post #confirm_doctor" do
      before do
        @user = FactoryGirl.create(:user, unconfirmed_doctor: true)
      end

      it "confirms the requested user is a doctor" do
        expect {
          post :confirm_doctor, {:user_id => @user.to_param}
          @user.reload
        }.to change(@user, :unconfirmed_doctor)
        expect(@user.has_role? :doctor).to be_truthy
        expect(@user.addresses.first.address_type).to eq 1
      end

      it "redirects to the users list" do
        post :confirm_doctor, {:user_id => @user.to_param}
        expect(response).to redirect_to(users_url)
      end
    end
  end
end

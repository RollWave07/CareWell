require 'spec_helper'

describe User do
  describe 'devise validations' do
    describe 'presence' do
      context 'when given an :email and :password' do
        it 'creates a new record' do
          new_user = User.create( email: 'peter@pan.com', password:"password")
          expect(new_user).to be_valid
          expect(User.count).to eq 1
        end
      end
      context 'when given nothing' do
        it 'fails to create a record' do
          new_user = User.create
          expect(new_user).to_not be_valid
          expect(User.count).to eq 0
          expect(new_user.errors.full_messages).to include("Email can't be blank", "Password can't be blank")
        end
      end
    end
  end
end
require 'rails_helper'

RSpec.describe DeleteUserService do
  describe ".perform" do
    context "valid id" do
      it "deletes a user" do
        user = get_test_user
        expect { described_class.new(user.id).perform }.to change { User.count }.by(-1)
      end
    end

    context "null id" do
      it "raises an error" do
        expect { described_class.new(nil).perform }.to raise_error
      end
    end

    context "negative id" do
      it "raises an error" do
        user = get_test_user
        expect { described_class.new(user.id * -1).perform }.to raise_error
      end
    end

    def get_test_user
      User.create(
        name: "João",
        email: "joao@gmail.com",
        password: "123"
      )

      user = User.last

      user
    end
  end
end

require 'rails_helper'

RSpec.describe GetUserDataService do
  describe ".perform" do
    context "valid id" do
      it "returns the user" do
        user = get_test_user
        expect(described_class.new(user.id).perform).to eq(user)
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

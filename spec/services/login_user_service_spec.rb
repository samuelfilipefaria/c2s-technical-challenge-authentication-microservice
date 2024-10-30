require 'rails_helper'

RSpec.describe LoginUserService do
  describe ".perform" do
    context "all valid parameters" do
      it "login the user" do
        user = get_test_user
        token = get_test_user_token(user)

        expect(described_class.new(user.email, user.password).perform).to eq(token)
      end
    end

    context "null e-mail" do
      it "raises an error" do
        user = get_test_user
        token = get_test_user_token(user)

        expect { described_class.new(nil, user.password).perform }.to raise_error
      end
    end

    context "empty e-mail" do
      it "raises an error" do
        user = get_test_user
        token = get_test_user_token(user)

        expect { described_class.new("", user.password).perform }.to raise_error
      end
    end

    context "wrong e-mail" do
      it "raises an error" do
        user = get_test_user
        token = get_test_user_token(user)

        expect { described_class.new("lfv,lsf,v", user.password).perform }.to raise_error
      end
    end

    context "null password" do
      it "raises an error" do
        user = get_test_user
        token = get_test_user_token(user)

        expect { described_class.new(user.email, nil).perform }.to raise_error
      end
    end

    context "empty password" do
      it "raises an error" do
        user = get_test_user
        token = get_test_user_token(user)

        expect { described_class.new(user.email, "").perform }.to raise_error
      end
    end

    context "wrong password" do
      it "raises an error" do
        user = get_test_user
        token = get_test_user_token(user)

        expect { described_class.new(user.email, "kfvmesm").perform }.to raise_error
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

    def get_test_user_token(test_user)
      JsonWebToken.encode_user_data({ user_data: test_user.id })
    end
  end
end

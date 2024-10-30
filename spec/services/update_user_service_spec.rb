require 'rails_helper'

RSpec.describe UpdateUserService do
  describe ".perform" do
    context "all valid parameters" do
      it "updates the user" do
        user = get_test_user

        subject = described_class.new(
          user.id,
          "Tiago",
          "tiago@gmail.com",
          "321"
        )

        subject.perform
        user.reload
        
        expect(user.name).to eq("Tiago")
        expect(user.email).to eq("tiago@gmail.com")
        expect(user.password).to eq("321")        
      end
    end

    context "passing only name" do
      it "updates the user name" do
        user = get_test_user

        subject = described_class.new(
          user.id,
          "Tiago"
        )

        subject.perform
        user.reload
        
        expect(user.name).to eq("Tiago")
        expect(user.email).to eq("joao@gmail.com")
        expect(user.password).to eq("123")        
      end
    end

    context "passing only e-mail" do
      it "updates the user e-mail" do
        user = get_test_user

        subject = described_class.new(
          user.id,
          nil,
          "tiago@gmail.com"
        )

        subject.perform
        user.reload
        
        expect(user.name).to eq("João")
        expect(user.email).to eq("tiago@gmail.com")
        expect(user.password).to eq("123")        
      end
    end

    context "passing only password" do
      it "updates the user password" do
        user = get_test_user

        subject = described_class.new(
          user.id,
          nil,
          nil,
          "321"
        )

        subject.perform
        user.reload
        
        expect(user.name).to eq("João")
        expect(user.email).to eq("joao@gmail.com")
        expect(user.password).to eq("321")        
      end
    end

    context "null name" do
      it "keeps the name" do
        user = get_test_user

        subject = described_class.new(
          user.id,
          nil,
          "tiago@gmail.com",
          "321"
        )

        subject.perform
        user.reload

        expect(user.name).to eq("João")
      end
    end

    context "empty name" do
      it "raises an error" do
        user = get_test_user

        subject = described_class.new(
          user.id,
          "",
          "tiago@gmail.com",
          "321"
        )

        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "null e-mail" do
      it "keeps the e-mail" do
        user = get_test_user

        subject = described_class.new(
          user.id,
          "João",
          nil,
          "321"
        )

        subject.perform
        user.reload

        expect(user.email).to eq("joao@gmail.com")
      end
    end

    context "empty e-mail" do
      it "raises an error" do
        user = get_test_user

        subject = described_class.new(
          user.id,
          "João",
          "",
          "321"
        )

        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "repeated e-mail" do
      it "raises an error" do
        User.create(
          name: "Outro Tiago",
          email: "tiago@gmail.com",
          password: "123"
        )

        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "null password" do
      it "keeps the password" do
        user = get_test_user

        subject = described_class.new(
          user.id,
          "João",
          "joao@gmail.com",
          nil
        )

        subject.perform
        user.reload

        expect(user.password).to eq("123")
      end
    end

    context "empty password" do
      it "raises an error" do
        user = get_test_user

        subject = described_class.new(
          user.id,
          "João",
          "joao@gmail.com",
          ""
        )

        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "null id" do
      it "raises an error" do
        user = get_test_user

        subject = described_class.new(
          nil,
          "João",
          "joao@gmail.com",
          "123"
        )

        expect { subject.perform }.to raise_error
      end
    end

    context "negative id" do
      it "raises an error" do
        user = get_test_user

        subject = described_class.new(
          user.id * -1,
          "João",
          "joao@gmail.com",
          "123"
        )

        expect { subject.perform }.to raise_error
      end
    end

    context "all null parameters" do
      it "keeps all parameters" do
        user = get_test_user

        subject = described_class.new(
          user.id,
          nil,
          nil,
          nil
        )

        subject.perform
        user.reload
        
        expect(user.name).to eq(user.name)
        expect(user.email).to eq(user.email)
        expect(user.password).to eq(user.password)
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

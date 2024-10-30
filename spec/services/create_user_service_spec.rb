require 'rails_helper'

RSpec.describe CreateUserService do
  subject {
    described_class.new(
      "João",
      "joao@gmail.com",
      "123"
    )
  }

  describe ".perform" do
    context "all valid parameters" do
      it "creates the user" do
        expect { subject.perform }.to change { User.count }.by(1)
      end
    end

    context "null name" do
      it "raises an error" do
        subject.name = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "empty name" do
      it "raises an error" do
        subject.name = ""
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "null e-mail" do
      it "raises an error" do
        subject.email = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "empty e-mail" do
      it "raises an error" do
        subject.email = ""
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "repeated e-mail" do
      it "raises an error" do
        User.create(
          name: "João",
          email: "joao@gmail.com",
          password: "123"
        )

        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "null password" do
      it "raises an error" do
        subject.password = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "empty password" do
      it "raises an error" do
        subject.password = ""
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "all null parameters" do
      it "raises an error" do
        subject.name = nil
        subject.email = nil
        subject.password = nil
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end

    context "all empty parameters" do
      it "raises an error" do
        subject.name = ""
        subject.email = ""
        subject.password = ""
        expect { subject.perform }.to raise_error(ArgumentError)
      end
    end
  end
end

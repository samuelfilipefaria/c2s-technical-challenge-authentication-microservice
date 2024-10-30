require 'rails_helper'

RSpec.describe User, :type => :model do
  subject {
    described_class.new(
      name: "João",
      email: "joao@gmail.com",
      password: "123"
    )
  }

  context "all valid parameters" do
    it "is a valid user" do
      expect(subject).to be_valid
    end
  end

  context "null name" do
    it "is not a valid user" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

  context "empty name" do
    it "is not a valid user" do
      subject.name = ""
      expect(subject).to_not be_valid
    end
  end

  context "null email" do
    it "is not a valid user" do
      subject.email = nil
      expect(subject).to_not be_valid
    end
  end

  context "empty email" do
    it "is not a valid user" do
      subject.email = ""
      expect(subject).to_not be_valid
    end
  end

  context "null password" do
    it "is not a valid user" do
      subject.password = nil
      expect(subject).to_not be_valid
    end
  end

  context "empty password" do
    it "is not a valid user" do
      subject.password = ""
      expect(subject).to_not be_valid
    end
  end
end

require 'spec_helper'

describe SinatraAdmin::Admin do
  subject do
    SinatraAdmin::Admin.new(email: "admin@mail.com", password: "admin")
  end

  it 'includes Mongoid::Document' do
    expect(described_class < Mongoid::Document).to eq(true)
  end

  it 'hashes password' do
    expect(subject.password).not_to eql('admin')
    expect(subject.password == 'admin').to eq(true)
  end

  describe 'validations' do
    [:email, :password_hash].each do |required_attr|
      it "#{required_attr} is required" do
        subject.send("#{required_attr}=", nil)
        subject.valid?
        expect(subject.errors[required_attr]).to include("can't be blank")
      end
    end

    it 'email should be valid format' do
      subject.email = 'invalid'
      subject.valid?
      expect(subject.errors[:email]).to include("is not an email")
    end
  end
end


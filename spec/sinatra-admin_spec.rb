require 'spec_helper'

class User; end

describe SinatraAdmin do
  describe '.register' do
    let(:resource) { 'User' }

    it 'registers a resource' do
      expect(described_class::Register).to receive(:add).with(resource)
      described_class.register(resource)
    end
  end

  describe '.config' do
    it 'returns instance of SinatraAdmin::Config' do
      expect(described_class.config).to be_instance_of(described_class::Config)
    end
  end

  describe '.root' do
    let(:default_root) { 'User' }

    it 'sets root to config' do
      described_class.root default_root
      expect(described_class.config.root).to eq(default_root)
    end
  end

  describe '.admin_model' do
    let(:admin_model) { 'User' }

    it 'sets admin_model to config' do
      described_class.admin_model admin_model
      expect(described_class.config.admin_model).to eq(User)
    end
  end
end

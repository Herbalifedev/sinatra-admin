require 'spec_helper'

class User; end

describe SinatraAdmin do
  describe '.register' do
    context 'when is registered a model' do
      let(:resource) { 'User' }

      it 'registers a new resource(model)' do
        expect(described_class::Register::Model).to receive(:add).with(User)
        described_class.register(resource)
      end
    end

    context 'when is registered a custom page' do
      let(:resource) { 'Custom Page' }

      it 'registers a new resource(custom)' do
        expect(described_class::Register::Custom).to receive(:add).with('Custom Page')
        described_class.register(resource)
      end
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

  describe '.add_views_from' do
    let(:expected_views) do
      described_class::App.views << "#{Dummy.views}/admin"
    end

    it 'adds main app views to SinatraAdmin views' do
      described_class.add_views_from(Dummy)
      expect(described_class::App.views).to eq(expected_views)
    end
  end
end

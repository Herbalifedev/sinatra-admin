require 'spec_helper'

class User; end

describe SinatraAdmin::Config do
  describe ':ATTRIBUTES' do
    let(:expected_attrs) { [:root, :admin_model] }
    it { expect(described_class::ATTRIBUTES).to eq(expected_attrs) }
  end

  describe '#default_route' do
    context 'when root is initialized' do
      before do 
        subject.root = 'User'
      end

      context 'when defined root is not registered' do
        it 'raises RegistrationException' do
          expect {
            subject.default_route
          }.to raise_error(SinatraAdmin::RegistrationException, 'The resource User was not registered')
        end
      end

      context 'when defined root is registered' do
        before  do
          subject.routes << 'users'
        end

        it 'returns /admin/users' do
          expect(subject.default_route).to eq('/admin/users')
        end
      end
    end

    context 'when root is not initialized' do
      context 'when there are not registered routes' do
        it 'raises RegistrationException' do
          expect {
            subject.default_route
          }.to raise_error(SinatraAdmin::RegistrationException, 'You should register at least one resource')
        end
      end

      context 'when there are registered routes' do
        before do
          subject.routes << 'tags' << 'users'
        end

        it 'returns first registered route' do
          expect(subject.default_route).to eq('/admin/tags')
        end
      end
    end
  end

  describe '#admin_model' do
    context 'when model_name was initialized with User' do
      before do
        subject.admin_model = User
      end

      it 'returns User' do
        expect(subject.admin_model).to eq(User)
      end
    end

    context 'when model_name was not initialized' do
      before do
        subject.admin_model = nil
      end

      it 'returns SinatraAdmin::Admin' do
        expect(subject.admin_model).to eq(SinatraAdmin::Admin)
      end
    end
  end

  describe '#routes' do
    context 'when there are not registered routes' do
      it 'returns []' do
        expect(subject.routes).to eq([])
      end
    end

    context 'when there are registered routes' do
      before do
        subject.routes << 'users'
      end

      it 'returns array with routes' do
        expect(subject.routes).to eq(['users'])
      end
    end
  end

  describe '#reset!' do
    it 'sets nil to ALL config attributes' do
      described_class::ATTRIBUTES.each do |attr|
        expect(subject).to receive("#{attr.to_s}=").with(nil)
      end
      subject.reset!
    end

    it 'clears routes array' do
      subject.routes << 'users'
      subject.reset!
      expect(subject.routes).to eq([])
    end
  end
end

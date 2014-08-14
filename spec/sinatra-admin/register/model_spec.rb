require 'spec_helper'

class Tag; end

describe SinatraAdmin::Register::Model do
  before { SinatraAdmin.config.reset! }

  describe '.add' do
    context 'when resource has been registered already' do
      before { described_class.add 'Tag' }

      it 'raises RegistrationException' do
        expect{
          SinatraAdmin.register 'Tag'
        }.to raise_error(SinatraAdmin::RegistrationException, "The resource Tag is already registered")
      end
    end

    context 'when resource has not been registered yet' do
      it 'decode namespaced models correctly' do
        described_class.add 'SinatraAdmin::Admin'
        expect(SinatraAdmin.config.routes).to include('sinatra_admin_admins')
      end

      it 'adds route to config' do
        described_class.add 'Tag'
        expect(SinatraAdmin.config.routes).to include('tags')
      end
    end
  end
end

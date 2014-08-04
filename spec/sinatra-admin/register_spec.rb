require 'spec_helper'

class Tag; end

describe SinatraAdmin::Register do
  describe '.add' do
    before { SinatraAdmin.config.reset! }

    context 'when resource has been registered already' do
      before { SinatraAdmin.register 'Tag' }

      it 'raises RegistrationException' do
        expect{
          SinatraAdmin.register 'Tag'
        }.to raise_error(SinatraAdmin::RegistrationException, "The resource Tag is already registered")
      end
    end

    context 'when resource has not been registered yet' do
      it 'adds route to config' do
        SinatraAdmin.register 'Tag'
        expect(SinatraAdmin.config.routes).to include('tags')
      end
    end
  end
end

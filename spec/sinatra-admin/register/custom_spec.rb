require 'spec_helper'

describe SinatraAdmin::Register::Custom do
  before { SinatraAdmin.config.reset! }

  describe '.add' do
    context 'when block is given' do
      context 'when resource has been registered already' do
        before do 
          described_class.add 'Custom Page' do
            get '/' do
              puts "In tag custom page"
            end
          end
        end

        it 'raises RegistrationException' do
          expect{
            SinatraAdmin.register 'Custom Page' do
              get '/' do
                puts "In tag custom page"
              end
            end
          }.to raise_error(SinatraAdmin::RegistrationException, "The resource Custom Page is already registered")
        end
      end

      context 'when resource has not been registered yet' do
        it 'adds route to config' do
          described_class.add 'Custom Page' do
            get '/' do
              puts "In tag custom page"
            end
          end
          expect(SinatraAdmin.config.routes).to include('custom_pages')
        end
      end
    end
  end
end

require 'spec_helper'

describe SinatraAdmin::Register::Base do
  before { SinatraAdmin.config.reset! }

  describe '.add' do
    it 'raises exception(this is an abstract class)' do
      expect{
        described_class.add 'Tag'
      }.to raise_error(NotImplementedError, "You must implement me!")
    end
  end
end

require 'spec_helper'

describe SinatraAdmin::Register do
  it 'defines ::Base' do
    expect(defined? described_class::Base).to eq('constant')
  end

  it 'defines ::Model' do
    expect(defined? described_class::Model).to eq('constant')
  end

  it 'defines ::Custom' do
    expect(defined? described_class::Custom).to eq('constant')
  end
end

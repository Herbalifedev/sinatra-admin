require 'spec_helper'

describe SinatraAdmin::App do
  it 'inherits from Sinatra::Base' do
    expect(described_class < Sinatra::Base).to eq(true)
  end

  it 'registers Sinatra::Namespace' do
    expect(described_class.extensions).to include(Sinatra::Namespace)
  end

  it 'adds Rack::MethodOverride middleware' do
    expect(described_class.middleware[0]).to include(Rack::MethodOverride)
  end

  it 'adds Rack::Session::Cookie middleware' do
    expect(described_class.middleware[1]).to include(Rack::Session::Cookie)
  end

  it 'adds Rack::Csrf middleware' do
    expect(described_class.middleware[2]).to include(Rack::Csrf)
  end
end

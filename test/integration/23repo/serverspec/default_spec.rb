require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('puppet') do
  it { should be_installed }
end


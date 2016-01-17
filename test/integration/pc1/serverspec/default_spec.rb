require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('puppet-agent') do
  it { should be_installed }
end


require 'serverspec'

# Required by serverspec
set :backend, :exec

set :path, '/opt/puppetlabs/bin:$PATH'

describe package('puppet-agent') do
  it { should be_installed }
end

describe command('puppet --version') do
    its(:stdout) { should match /^4\.2\./ }
end

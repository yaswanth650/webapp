 describe port(80) do
  it { should_not be_listening }
end

describe port(443) do
  it { should be_listening }
  its('protocols') {should include 'tcp'}
end

 describe file("/trufflehog") do
     it { should exist }
  end

describe file('/trufflehog') do
     its('size') { should be >= 120 }
 end

describe sshd_config do
     its('Protocol') { should eq '2' }
   end

describe sshd_config do
     its('Protocol') { should eq 2 }
 end
 describe sshd_config do
     its('Ciphers') { should_not match '/cbc/' }
   end

 describe docker_image(name: 'gasellix/trufflehog') do
  it { should exist }
  it { should be_running }
end

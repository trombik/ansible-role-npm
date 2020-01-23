require "spec_helper"
require "serverspec"

package = "npm"
extra_packages = []

case os[:family]
when "openbsd"
  package = "node"
when "freebsd"
  package = "www/npm"
when "redhat"
  package = "nodejs"
end

describe package(package) do
  it { should be_installed }
end

extra_packages.each do |p|
  describe package p do
    it { should be_installed }
  end
end

describe command("npm --version") do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq "" }
  its(:stdout) { should match(/^\d+\.\d+\.\d+$/) }
end

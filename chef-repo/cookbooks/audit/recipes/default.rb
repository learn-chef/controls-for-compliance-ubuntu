#
# Cookbook Name:: audit
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
control_group 'Validate web services' do
  control 'Ensure no web files are owned by the root user' do
    Dir.glob('/var/www/html/**/*') {|web_file|
      it 'is not owned by the root user' do
        expect(file(web_file)).to_not be_owned_by('root')
      end
    }
  end
end

control_group 'Validate network configuration and firewalls' do
  control 'Ensure the firewall is active' do
    it 'has the firewall active' do
      expect(service('ufw')).to be_enabled
      expect(service('ufw')).to be_running
      expect(command('ufw status').stdout).to match(/Status: active/)
    end
  end
end

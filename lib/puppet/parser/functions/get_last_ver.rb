module Puppet::Parser::Functions
	newfunction(:get_last_ver, :type => :rvalue) do |args|
		require 'open-uri'
		url = 'http://framework.zend.com/api/zf-version?v=' + args[0]
		return open(url).read
	end
end

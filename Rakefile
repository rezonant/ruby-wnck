require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('wnck', '0.1.0') do |p|
	p.description = "Use the GNOME Window Navigator Construction Kit from Ruby"
	p.url = "http://github.com/rezonant/ruby-wnck"
	p.author = "William Lahti"
	p.email = "wilahti@gmail.com"
	p.ignore_pattern = ["tmp/*", "script/*", "*.bak", "*.swp", "*~"]
	p.development_dependencies = []
	p.runtime_dependencies = ["gtk2", "ffi"]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

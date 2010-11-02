require ::File.dirname(__FILE__) + '/../lib/wnck.rb'
require 'ostruct'

# NOTE: Run these from an environment with DISPLAY set to a valid, listening X11 server!

describe Wnck do
	def self.it_wraps(method, pred = {})
		it "wraps #{method}" do
			Wnck.should respond_to method
		end
	end

	it_wraps "wnck_screen_get_default"
	it_wraps "wnck_screen_get"
	it_wraps "wnck_screen_get_windows"
end

describe Wnck::Screen do
	it "can retrieve the default screen" do
		screen = Wnck::Screen.default
		screen.should be_a_kind_of Wnck::Screen
	end

	it "knows how many screens there are" do
		Wnck::Screen.count.should be_a Numeric
	end

	it "gives a realistic number for screen count" do
		Wnck::Screen.count.should > 0
	end

	it "can retrieve screens by index" do
		Wnck::Screen.count.times { |i| Wnck::Screen.get(i).should be_a Wnck::Screen }
	end

end

describe Wnck::Screen do
	before(:each) do
		@screen = Wnck::Screen.default
	end

	it "knows its own height" do
		@screen.height.should be_a_kind_of Numeric
	end

	it "knows its own width" do
		@screen.width.should be_a_kind_of Numeric
	end

	it "knows the name given to it by the window manager" do
		@screen.name
	end

	it "gives a reasonable width for the default screen" do
		@screen.width.should >= 320
		@screen.width.should < 250000
	end

	it "gives a reasonable height for the default screen" do
		@screen.height.should >= 240
		@screen.height.should < 250000
	end

	it "provides toggle_show_desktop" do
		@screen.should respond_to :toggle_show_desktop
	end

	it "can provide the active window" do
		@screen.should respond_to :active_window
		@screen.active_window
	end

	it "can provide the previously active window" do
		@screen.should respond_to :previously_active_window
		@screen.previously_active_window
	end

	it "can list its windows" do
		windows = @screen.windows
		windows.should be_true
		windows.should respond_to :each
	end

	it "gives a realistic number of total windows amongst all screens" do
		total = 0
		Wnck::Screen.count.times { |i| total += Wnck::Screen.get(i).windows.length }
		total.should > 1
	end

	it "can query the window manager for supported features" do
		@screen.should respond_to :net_wm_supports?
		@screen.net_wm_supports? "_NET_WM_STATE_STICKY"
	end

	it "can force the list of windows to be updated." do
		@screen.should respond_to :force_update
		@screen.force_update
	end
end

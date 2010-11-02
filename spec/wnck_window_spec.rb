require ::File.dirname(__FILE__) + '/../lib/wnck.rb'

describe Wnck::Window do
	before(:all) do
		Gtk.init
		gw = Gtk::Window.new
		gw.title = "WnckTestWindow"
		gw.realize
		gw.present

		10.times { Gtk.main_iteration; Wnck::Screen.default.force_update; sleep 1 }
		@window = Wnck::Window.new(gw.window.xid)

		raise Exception.new "Could not find test window!" unless @window
	end

	def self.it_has_predicate(p)
		it "knows if it's #{p.to_s.gsub('_', ' ')}" do
			@window.should respond_to p
			@window.send p
		end
	end

	it_has_predicate :minimized?
	it_has_predicate :maximized?
	it_has_predicate :maximized_horizontally?
	it_has_predicate :maximized_vertically?
	it_has_predicate :shaded?
	it_has_predicate :above?
	it_has_predicate :pinned?
	it_has_predicate :skip_pager?
	it_has_predicate :skip_tasklist?
	it_has_predicate :fullscreen?
	it_has_predicate :sticky?
	it_has_predicate :below?
	it_has_predicate :has_name?
	it_has_predicate :has_icon_name?

	it "can horizontally maximize itself" do
		@window.should respond_to :maximize_horizontally
		@window.maximize_horizontally
	end

	it "can unminimize itself" do
		@window.should respond_to :unminimize
		@window.unminimize Gtk.current_event_time
	end

	it "can horizontally unmaximize itself" do
		@window.should respond_to :unmaximize_horizontally
		@window.unmaximize_horizontally
	end

	it "can vertically maximize itself" do
		@window.should respond_to :maximize_vertically
		@window.maximize_vertically
	end

	it "can vertically unmaximize itself" do
		@window.should respond_to :unmaximize_vertically
		@window.unmaximize_vertically
	end

	it "can maximize itself" do
		@window.should respond_to :maximize
		@window.maximize
	end

	it "can unmaximize itself" do
		@window.should respond_to :unmaximize
		@window.unmaximize
	end

	it "can shade itself" do
		@window.should respond_to :shade
		@window.shade
	end

	it "can unshade itself" do
		@window.should respond_to :unshade
		@window.unshade
	end

	it "can pin itself" do
		@window.should respond_to :pin
		@window.pin
	end

	it "can unpin itself" do
		@window.should respond_to :unpin
		@window.unpin
	end

	it "can stick itself" do
		@window.should respond_to :stick
		@window.stick
	end

	it "can unstick itself" do
		@window.should respond_to :unstick
		@window.unstick
	end

	it "can put itself above other windows" do
		@window.should respond_to :make_above
		@window.make_above
	end

	it "can stop itself from being above other windows" do
		@window.should respond_to :unmake_above
		@window.unmake_above
	end

	it "can stop itself from being below other windows" do
		@window.should respond_to :unmake_below
		@window.unmake_below
	end

	it "can put itself below other windows" do
		@window.should respond_to :make_below
		@window.make_below
	end

	it "can close itself" do
		@window.should respond_to :close
		#@window.close		# this really doesn't seem like a nice thing to do to testers...
	end

	it "can minimize itself" do
		@window.should respond_to :minimize
		@window.minimize	
	end

	it "can maximize itself" do
		@window.should respond_to :maximize
		@window.maximize
	end

	it "can unmaximize itself" do
		@window.should respond_to :unmaximize
		@window.unmaximize
	end

	it "can minimize itself" do
		@window.should respond_to :minimize
		@window.minimize
	end

	it "knows its icon name" do
		@window.should respond_to :icon_name
		@window.icon_name.should be_an_instance_of String
	end

	it "knows its name" do
		@window.should respond_to :name
		@window.name.should be_an_instance_of String
	end

	it "can maximize and unmaximize a window" do
		@window.should respond_to :maximize
		@window.should respond_to :unmaximize
		if @window.maximized? 		# Might as well try not to screw up the tester's desktop too badly :-)
			@window.unmaximize
			@window.maximize
		else
			@window.maximize
			@window.unmaximize
		end
	end
end

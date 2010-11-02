# 
# wnck for ruby
#
# Copyright © 2010 William Lahti
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE. 
#

#require 'rubygems'
require 'gtk2'		# gtk initialization must be done or wnck functions segfault
require 'ffi'

module Wnck
	module GLib
		extend FFI::Library
		ffi_lib "libglib-2.0.so"
		attach_function :g_list_nth_data, [:pointer, :uint32], :pointer
		attach_function :g_list_length, [:pointer], :uint 
	end

	extend FFI::Library
	ffi_lib "libwnck-1.so.22"
	

# Shortcuts for C types used by the API
	ptr = :pointer;		ul = :ulong;	str = :string;		bool = :bool;	int = :int;			
	uint = :uint;		void = :void;	u32 = :uint32;		 u = :uint;

# Enumerations
	module WindowState
		%w{NORMAL DESKTOP DOCK DIALOG TOOLBAR MENU UTILITY SPLASHSCREEN
			}.inject(0) { |value,state| 1 + eval("#{state} = value") }
	end

	module WindowActions
		%w{MOVE RESIZE SHADE STICK MAXIMIZE_HORIZONTALLY MAXIMIZE_VERTICALLY CHANGE_WORKSPACE CLOSE UNMAXIMIZE_HORIZONTALLY 
		   UNMAXIMIZE_VERTICALLY UNSHADE UNSTICK MINIMIZE UNMINIMIZE MAXIMIZE UNMAXIMIZE FULLSCREEN ABOVE BELOW
			}.inject(1) { |value,state| (eval "#{state} = value") << 1 }
	end
	
	module WindowGravity
		%w{CURRENT NORTHWEST NORTH NORTHEAST WEST CENTER EAST SOUTHWEST SOUTH SOUTHEAST STATIC 
			}.inject(0) { |value,state| 1 + (eval "#{state} = value") }
	end

	module WnckWindowMoveResizeMask
		%w{CHANGE_X CHANGE_Y CHANGE_WIDTH CHANGE_HEIGHT
			}.inject(1) { |value,state| (eval "#{state} = value") << 1 }
	end

# class WnckScreen
	attach_function :wnck_screen_get_default,					[],						ptr
	attach_function :wnck_screen_get, 							[int], 					ptr
	attach_function :wnck_screen_get_for_root, 					[ul], 					ptr
	attach_function :wnck_screen_get_number,	 				[ptr], 					int
	attach_function :wnck_screen_get_width, 					[ptr], 					int
	attach_function :wnck_screen_get_height, 					[ptr],	 				int
	attach_function :wnck_screen_force_update, 					[ptr],					void
	attach_function :wnck_screen_get_window_manager_name, 		[ptr], 					str
	attach_function :wnck_screen_net_wm_supports,				[ptr, str],				bool
	attach_function :wnck_screen_get_active_window, 			[ptr], 					ptr
	attach_function :wnck_screen_get_previously_active_window, 	[ptr], 					ptr
	attach_function :wnck_screen_get_windows, 					[ptr], 					ptr
	attach_function :wnck_screen_get_windows_stacked, 			[ptr], 					ptr
	attach_function :wnck_screen_get_active_workspace,			[ptr],					ptr
	attach_function :wnck_screen_get_workspaces,				[ptr],					ptr
	attach_function :wnck_screen_get_workspace,					[ptr, int],				ptr
	attach_function :wnck_screen_get_workspace_index,			[ptr, ptr],				int
	attach_function :wnck_screen_get_workspace_neighbor,		[ptr, ptr, int],		int
	attach_function :wnck_screen_toggle_showing_desktop, 		[ptr, bool],			void

# class WnckWindow
	attach_function :wnck_window_get, 							[ul],					ptr	
	attach_function :wnck_window_get_screen,					[ptr],					ptr	
	attach_function :wnck_window_has_name,						[ptr],					bool		
	attach_function :wnck_window_get_name,						[ptr],					str		
	attach_function :wnck_window_has_icon_name,					[ptr],					bool		
	attach_function :wnck_window_get_icon_name,					[ptr],					str		
	attach_function :wnck_window_get_icon_is_fallback,			[ptr],					bool		
	attach_function :wnck_window_get_icon,						[ptr],					ptr	
	attach_function :wnck_window_get_mini_icon,					[ptr], 					ptr	
	attach_function :wnck_window_get_application,				[ptr], 					ptr	
	attach_function :wnck_window_get_transient,					[ptr], 					ptr	
	attach_function :wnck_window_get_group_leader,				[ptr], 					ul		
	attach_function :wnck_window_get_xid,						[ptr], 					ul		
	attach_function :wnck_window_get_class_group,				[ptr], 					ptr	
	attach_function :wnck_window_get_session_id,				[ptr], 					str		
	attach_function :wnck_window_get_session_id_utf8,			[ptr], 					str		
	attach_function :wnck_window_get_pid,						[ptr], 					int		
	attach_function :wnck_window_get_sort_order,				[ptr], 					int		
	attach_function :wnck_window_set_sort_order,				[ptr, int], 			void		
	attach_function :wnck_window_get_window_type,				[ptr], 					int			
	attach_function :wnck_window_set_window_type,				[ptr, int],			 	void		
	attach_function :wnck_window_get_state,						[ptr], 					int		
	attach_function :wnck_window_is_minimized,					[ptr],					bool		
	attach_function :wnck_window_is_maximized_horizontally,		[ptr],					bool		
	attach_function :wnck_window_is_maximized_vertically,		[ptr],					bool		
	attach_function :wnck_window_is_maximized,					[ptr],					bool		
	attach_function :wnck_window_is_shaded,						[ptr],					bool		
	attach_function :wnck_window_is_pinned,						[ptr],					bool		
	attach_function :wnck_window_is_sticky,						[ptr],					bool		
	attach_function :wnck_window_is_above,						[ptr],	 				bool		
	attach_function :wnck_window_is_below,						[ptr],	 				bool		
	attach_function :wnck_window_is_skip_pager,					[ptr], 					bool		
	attach_function :wnck_window_is_skip_tasklist,				[ptr],	 				bool		
	attach_function :wnck_window_is_fullscreen,					[ptr],					bool		
	attach_function :wnck_window_needs_attention,				[ptr],					bool		
	attach_function :wnck_window_or_transient_needs_attention,	[ptr],					bool		
	attach_function :wnck_window_minimize,						[ptr],	 				void		
	attach_function :wnck_window_get_actions,					[ptr],	 				int		
	attach_function :wnck_window_maximize_horizontally,			[ptr],					void		
	attach_function :wnck_window_unminimize,					[ptr, uint],			void		
	attach_function :wnck_window_unmaximize_horizontally,		[ptr],					void		
	attach_function :wnck_window_maximize_vertically,			[ptr],					void		
	attach_function :wnck_window_unmaximize_vertically,			[ptr],					void		
	attach_function :wnck_window_maximize,						[ptr],					void		
	attach_function :wnck_window_unmaximize,					[ptr],	 				void		
	attach_function :wnck_window_shade,							[ptr],	 				void		
	attach_function :wnck_window_unshade,						[ptr],	 				void		
	attach_function :wnck_window_pin,							[ptr],	 				void		
	attach_function :wnck_window_unpin,							[ptr],	 				void		
	attach_function :wnck_window_stick,							[ptr],	 				void		
	attach_function :wnck_window_unstick,						[ptr],	 				void		
	attach_function :wnck_window_make_above,					[ptr],					void		
	attach_function :wnck_window_unmake_above,					[ptr],					void		
	attach_function :wnck_window_make_below,					[ptr],					void		
	attach_function :wnck_window_unmake_below,					[ptr],					void		
	attach_function :wnck_window_set_skip_pager,				[ptr, bool],			void		
	attach_function :wnck_window_set_skip_tasklist,				[ptr, bool],			void		
	attach_function :wnck_window_set_fullscreen,				[ptr, bool],			void		
	attach_function :wnck_window_close,							[ptr, u32],				void		
	attach_function :wnck_window_get_workspace,					[ptr],					ptr	
	attach_function :wnck_window_is_on_workspace,				[ptr, ptr],				bool		

	attach_function :wnck_window_is_visible_on_workspace,		[ptr, ptr], bool
	attach_function :wnck_window_move_to_workspace,				[ptr, ptr], void
	attach_function :wnck_window_is_in_viewport,				[ptr, ptr], bool
	attach_function :wnck_window_activate,						[ptr, u32], void
	attach_function :wnck_window_is_active,						[ptr], bool
	attach_function :wnck_window_is_most_recently_activated,	[ptr], bool
	attach_function :wnck_window_activate_transient,			[ptr, u32], void
	attach_function :wnck_window_transient_is_most_recently_activated,	[ptr], bool
	attach_function :wnck_window_set_icon_geometry,				[ptr, int, int, int, int], void
	attach_function :wnck_window_get_client_window_geometry,	[ptr, ptr, ptr, ptr, ptr], void
	attach_function :wnck_window_get_geometry,					[ptr, ptr, ptr, ptr, ptr], void
	attach_function :wnck_window_set_geometry,					[ptr, int, int, int, int, int, int], void
	attach_function :wnck_window_keyboard_move,					[ptr], void
	attach_function :wnck_window_keyboard_size,					[ptr], void

	class Screen
		def initialize(handle)
			@handle = handle
			Wnck::wnck_screen_force_update handle
		end
		
		def self.new(handle)
			return get(handle) if handle.kind_of? Integer
			return nil if handle.null?
			super handle
		end

		def self.default()   Screen.new(Wnck::wnck_screen_get_default)   end
		def self.count()   i = 0; i += 1 while get i; i   end
		def self.screens()   (0 ... Screen.count).collect { |i| Screen.get(i) }	end
		def self.each(&b)   screens.each &b   end
		def self.get(i)
			h = Wnck::wnck_screen_get(i)
			(h.null?) ? nil : Screen.new(h)
		end

private
		def self.add_accessor(method, native = "get_#{method}")
			return method.each { |pair| add_accessor *pair } if method.kind_of? Hash
			eval "define_method(method) { r = Wnck.send(:wnck_screen_#{native}, @handle); (yield self, r if block_given?) or r }"
		end

		def self.add_accessors(*names, &b)
			names.each do |n|
				((n.kind_of?(Hash) and n.length > 1) ? 
					n.each { |pair| add_accessor *pair, &b }   :
					add_accessor(n, &b))
			end
		end

public
		attr_reader :handle

		def net_wm_supports?(atom)		Wnck::wnck_screen_net_wm_supports(@handle, atom)							end

		add_accessors :width, :height, :number, 
					  :force_update => 'force_update',
					  :name => 'get_window_manager_name',
					  :toggle_show_desktop => 'toggle_showing_desktop'

		add_accessors(:active_window			=> 'get_active_window',
					  :previously_active_window => 'get_previously_active_window'
		) { |s,handle| Window.new s, handle }
		
#		def force_update()				Wnck::wnck_screen_force_update(@handle)										end
#		def width()						Wnck::wnck_screen_get_width(@handle)										end
#		def height()					Wnck::wnck_screen_get_height(@handle)										end
#		def number()					Wnck::wnck_screen_get_number(@handle)										end
#		def name()						Wnck::wnck_screen_get_window_manager_name(@handle) 							end
#		def active_window()				Window.new(self, Wnck::wnck_screen_get_active_window(@handle))				end
#		def previously_active_window()	Window.new(self, Wnck::wnck_screen_get_previously_active_window(@handle))	end
#		def toggle_show_desktop()		Wnck::wnck_screen_toggle_showing_desktop(@handle)							end
		def workspace_at(index)   Workspace.new Wnck::wnck_screen_get_workspace(@handle, index)   end
		def workspace_index(ws)   Wnck::wnck_screen_get_workspace_index(@handle, ws.handle)   end

		{ :workspaces =>	proc { |s,d| Workspace.new s, d }, 
		  :windows =>		proc { |s,d| Window.new d }, 
		}.each do |name, generator|
			define_method(name) do
				list = Wnck.send "wnck_screen_get_#{name}", @handle
				items = []

				GLib::g_list_length(list).times do |i|
					items << (generator.call self, GLib::g_list_nth_data(list, i))
				end

				items
			end
		end
	end

	class Window
		def initialize(handle)
			screen = self.class.prepare_screen(Screen.new(Wnck::wnck_window_get_screen(handle)))
			@screen = screen
			@handle = handle
		end

		def self.new(handle)
			return get(handle) if handle.kind_of? Integer
			return nil if handle.null?
			super handle
		end
		
		attr_reader :handle, :screen

private
		def self.prepare_screen(scr) scr.kind_of?(Integer) ? Screen.get(scr) : scr  end

public
		def self.get(xid)
			screen = prepare_screen(screen)
			h = Wnck::wnck_window_get(xid)
			return nil if h.null?
			Window.new(h)
		end

		def maximize_horizontally()		Wnck::wnck_window_maximize_horizontally(@handle)		end
		def unminimize()				Wnck::wnck_window_unminimize(@handle)					end																								
		def unmaximize_horizontally()	Wnck::wnck_window_unmaximize_horizontally(@handle)		end
		def maximize_vertically()		Wnck::wnck_window_maximize_vertically(@handle)			end
		def unmaximize_vertically()		Wnck::wnck_window_unmaximize_vertically(@handle)		end
		def maximize()					Wnck::wnck_window_maximize(@handle)						end
		def unmaximize()				Wnck::wnck_window_unmaximize(@handle)					end
		def shade()						Wnck::wnck_window_shade(@handle)						end
		def unshade()					Wnck::wnck_window_unshade(@handle)						end
		def pin()						Wnck::wnck_window_pin(@handle)							end
		def unpin()						Wnck::wnck_window_unpin(@handle)						end
		def stick()						Wnck::wnck_window_stick(@handle)						end
		def unstick()					Wnck::wnck_window_unstick(@handle)						end
		def make_above()				Wnck::wnck_window_make_above(@handle)					end
		def unmake_above()				Wnck::wnck_window_unmake_above(@handle)					end
		def unmake_below()				Wnck::wnck_window_unmake_below(@handle)					end
		def make_below()				Wnck::wnck_window_make_below(@handle)					end
		def close()						Wnck::wnck_window_close(@handle)						end
		def minimize()					Wnck::wnck_window_minimize(@handle)						end
		def maximize()					Wnck::wnck_window_maximize(@handle)						end
		def unmaximize()				Wnck::wnck_window_unmaximize(@handle)					end
		def unminimize(ts)				Wnck::wnck_window_unminimize(@handle, ts)				end
		
		def actions()					Wnck::wnck_window_get_actions(@handle)					end
		def name()						Wnck::wnck_window_get_name(@handle)						end
		def icon_name()					Wnck::wnck_window_get_name(@handle)						end
		def skip_pager=(v) 				Wnck::wnck_window_set_skip_pager(@handle, v)			end
		def skip_tasklist=(v)			Wnck::wnck_window_set_skip_tasklist(@handle, v)			end
		def fullscreen=(v)				Wnck::wnck_window_set_fullscreen(@handle, v)			end

private
		def self.add_accessor(name, custom_name = nil)			# Add Window#method for Wnck::window_method()
			custom_name = name unless name
			define_method(custom_name) do
				Wnck.send("wnck_window_#{name}", @handle)
			end
		end

		def self.add_predicate(name)							# Add Window#pred? for Wnck::window_is_pred()
			name = name.to_s
			add_accessor "is_#{name[0,name.length - 1]}", name
		end
public

		add_accessor  :has_name, :has_name?
		add_accessor  :has_icon_name, :has_icon_name?
		add_predicate :minimized?
		add_predicate :maximized?
		add_predicate :maximized_horizontally?
		add_predicate :maximized_vertically?
		add_predicate :shaded?
		add_predicate :above?
		add_predicate :pinned?
		add_predicate :skip_pager?
		add_predicate :skip_tasklist?
		add_predicate :fullscreen?
		add_predicate :sticky?
		add_predicate :below?
	end
end

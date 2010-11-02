# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{wnck}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["William Lahti"]
  s.cert_chain = ["/home/liam/.gemcert/gem-public_cert.pem"]
  s.date = %q{2010-11-01}
  s.description = %q{Use the GNOME Window Navigator Construction Kit from Ruby}
  s.email = %q{wilahti@gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "lib/wnck.rb"]
  s.files = ["README.rdoc", "Rakefile", "lib/wnck.rb", "spec/wnck_screen_spec.rb", "spec/wnck_window_spec.rb", "Manifest", "wnck.gemspec"]
  s.homepage = %q{http://github.com/rezonant/wnck}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Wnck", "--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{wnck}
  s.rubygems_version = %q{1.3.5}
  s.signing_key = %q{/home/liam/.gemcert/gem-private_key.pem}
  s.summary = %q{Use the GNOME Window Navigator Construction Kit from Ruby}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<gtk2>, [">= 0"])
      s.add_runtime_dependency(%q<ffi>, [">= 0"])
    else
      s.add_dependency(%q<gtk2>, [">= 0"])
      s.add_dependency(%q<ffi>, [">= 0"])
    end
  else
    s.add_dependency(%q<gtk2>, [">= 0"])
    s.add_dependency(%q<ffi>, [">= 0"])
  end
end

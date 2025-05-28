# frozen_string_literal: true

require_relative 'lib/scryfall/version'

Gem::Specification.new do |spec|
  spec.name = 'ruby_scryfall'
  spec.version     = Scryfall::VERSION
  spec.authors     = ['Matthew Serre', 'Jaron Haberstroh']
  spec.email       = 'matthew.serre+github@gmail.com'

  spec.summary     = 'A gem for consuming the Scryfall REST-like API'
  spec.homepage    = 'https://github.com/MatthewSerre/ruby_scryfall'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata['rubygems_mfa_required'] = 'true'
end

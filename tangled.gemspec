lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tangled/version'

Gem::Specification.new do |spec|
  spec.name          = 'tangled'
  spec.version       = Tangled::VERSION
  spec.authors       = ['Tangled IT']
  spec.email         = ['team@tangled.it']

  spec.summary       = 'The Tangled Standard library, is an abstract ' \
                       'layer around the IOTA Core library.'
  spec.description   = "It's main purpose is to simplify developing on " \
                       "top of the 'Tangle'. And it will allow developers " \
                       'to go from idea to product much faster.'
  spec.homepage      = 'https://tangled.it'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/tangledit/tangled.rb'
    spec.metadata['changelog_uri'] = 'https://tangled.it'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'iota-ruby'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'sinatra'
end

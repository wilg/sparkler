# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sparkler/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Wil Gieseler"]
  gem.email         = ["supapuerco@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "sparkler"
  gem.require_paths = ["lib"]
  gem.version       = Sparkler::VERSION

  gem.add_dependency('colorize')
  gem.add_dependency('thor')
  gem.add_dependency('grit')

end
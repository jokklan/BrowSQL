# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'brow_sql/version'

Gem::Specification.new do |gem|
  gem.name          = "browsql"
  gem.version       = BrowSql::VERSION
  gem.authors       = ["Johan Frølich"]
  gem.email         = ["johanfrolich@gmail.com"]
  gem.description   = %q{A simple gem for browsing through your sql Database in Rails}
  gem.summary       = %q{A simple gem for browsing through your sql Database in Rails}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_dependency('sqlite3')
  gem.add_dependency('haml')
  gem.add_dependency('simple_form')
  gem.add_dependency('rails', '~> 3.2.6')
  
  gem.add_dependency('sass-rails', '~> 3.2.3')
  gem.add_dependency('coffee-rails', '~> 3.2.1')
  gem.add_dependency('bootstrap-sass', '~> 2.1.1')
end

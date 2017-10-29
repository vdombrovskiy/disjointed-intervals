system 'rm Gemfile' if File.exist?('Gemfile')

File.write('Gemfile', <<-GEMFILE)
  source 'https://rubygems.org'

  ruby '2.4.0'

  gem 'activesupport'

  gem 'minitest-reporters'
  gem 'minitest-hooks'
  gem 'minitest-spec-context'
GEMFILE

system 'bundle install'

require 'bundler'
Bundler.setup(:default)

require 'logger'

require 'active_support/all'

def require_recursively(path)
  location = File.expand_path(path, __dir__)
  Dir[location].each { |f| require f }
end

require_recursively('lib//**/*.rb')

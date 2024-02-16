source ENV['GEM_SOURCE'] || "https://rubygems.org"

def location_for(place)
  if place =~ /^(git[:@][^#]*)#(.*)/
    [{ git: $1, branch: $2, require: false }]
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { path: File.expand_path($1), require: false }]
  else
    [place, { require: false }]
  end
end

# Accommodate dependencies from the Vanagon Gemspec
gemspec

# Confine EC2 engine dependencies
group "ec2-engine" do
  gem "aws-sdk", "~> 3.1.0", require: false
end

# "lock_manager" is specified in development dependencies, to allow
# the use of unreleased versions of "lock_manager" during development.
group(:development, :test) do
  gem 'debug', '>= 1.0.0'
  gem 'fakefs'
  gem 'json'
  gem 'lock_manager', *location_for(ENV['LOCK_MANAGER_LOCATION'] || '>= 0')
  gem 'packaging', git: 'https://github.com/mhashizume/packaging.git', branch: 'maint/1.0.x/gem-source'
  gem 'rake', require: false
  gem 'rspec', '~> 3.0', require: false
  gem 'rubocop', '~> 1.0', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
  gem 'simplecov', require: false
  gem 'webmock', '~> 3.18'
  gem 'yard', require: false
end

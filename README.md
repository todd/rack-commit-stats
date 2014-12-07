rack-commit-stats
[![Build Status](https://travis-ci.org/todd/rack-commit-stats.svg?branch=master)](https://travis-ci.org/todd/rack-commit-stats)
[![Coverage Status](https://coveralls.io/repos/todd/rack-commit-stats/badge.png?branch=master)](https://coveralls.io/r/todd/rack-commit-stats?branch=master)
[![Code Climate](https://codeclimate.com/github/todd/rack-commit-stats/badges/gpa.svg)](https://codeclimate.com/github/todd/rack-commit-stats)
[![Dependency Status](https://gemnasium.com/todd/rack-commit-stats.svg)](https://gemnasium.com/todd/rack-commit-stats)
===========

rack-commit-stats is a Rack application that will display information about the
commit at a Git repository's HEAD. It's primary use case is for mounting within
another Rack-based application to display a quickly accessible digest of commit
information for that app; this is useful to quickly see what branch and commit
are deployed to your server environments if you don't have other tooling already
set up for that purpose.

## Getting Started
Add the gem to your Gemfile and run `bundle install`:
```
gem 'rack-commit-stats'
```
An important note: this gem is built on top of
[Rugged](https://github.com/libgit2/rugged), which requires CMake to be present
on your system. CMake should be available through your package manager of choice.

## For Rails
Mount the application on a new endpoint within your `routes.rb` file. You will
probably want to limit access to this endpoint using some sort of authentication
constraint you've established, though this is totally optional.

```ruby
mount RackCommitStats::App => '/deploy',
  constraints: YouShallNotPassConstraint.new
```

A Railtie is provided, so no additional configuration is required unless your
`.git` directory is on a non-standard path. If it is, you can set the path
in the affected environment configuration files.

```ruby
# production.rb
config.rack_commit_stats.repo_path = '../repo'
```

## For Sinatra
Simply add a new route with an endpoint of your choice and call the application
from inside of it.

```ruby
get '/deploy' do
  RackCommitStats::App.call env
end
```

Additionally, you can configure the Git repository path if you're not using
the standard `.git` directory or your app isn't being run from the repository
root.

```ruby
RackCommitStats.configure do |config|
  config.repo_path = '../.git'
end
```

## Example Output
```json
{
  "branch": "master",
  "commit": {
    "revision": "5ec0b96f8304cc9487172375a6f953cc73d3ffd5",
    "message": "I have a lovely bunch of coconuts.",
    "author": {
      "name": "Foo Bar",
      "email": "foo@bar.com"
    }
  }
}
```

## License

Copyright 2014 Todd Bealmear. See LICENSE for details.

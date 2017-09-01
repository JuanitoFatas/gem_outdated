# GemOutdated

Find out if a given gem and version is outdated or not.

## Installation

Add this line to your application's Gemfile then `bundle`:

```ruby
gem 'gem_outdated'
```

Or install it yourself as:

```
$ gem install gem_outdated
```

## Usage

```ruby
# Suppose latest Rails is 5.1.3
GemOutdated.outdated?("rails", "5.1.2")
=> true

# Already latest
GemOutdated.outdated?("rails", "5.1.3")
=> false

# Newer than latest
GemOutdated.outdated?("rails", "5.1.4.rc1")
=> false

# Version not exists
GemOutdated.outdated?("rails", "1.2.3.4")
=> VersionNotFound

# Gem not exists
GemOutdated.outdated?("greatest_rails", "1.0.0")
=> GemNotFound
```

## License, Contributor's Guidelines

- MIT license
- [Moya Contributors Guidelines][moya] which TLDR: means we give out push access easily and often.

[mit]: https://opensource.org/licenses/MIT
[moya]: https://github.com/Moya/contributors

SimpleMapnik
==========
[![Build Status](https://travis-ci.org/geoconcerns/simple_mapnik.svg)](https://travis-ci.org/geoconcerns/simple_mapnik)
[![Coverage Status](https://coveralls.io/repos/github/geoconcerns/simple_mapnik/badge.svg?branch=master)](https://coveralls.io/github/geoconcerns/simple_mapnik?branch=master)

Simple ruby access to the Mapnik library using [ruby-ffi](https://github.com/ffi/ffi) and [mapnik-c-api](https://github.com/springmeyer/mapnik-c-api). Adapted from [ffi-mapnik](https://github.com/scooterw/ffi-mapnik).

## Prerequisites

SimpleMapnik requires that Mapnik 3.x or 2.x be installed at `/usr/local/lib/libmapnik.*`. In addition, a C++ compiler and build environment is needed for the c api extension.

On Mac OS X:

- https://github.com/mapnik/mapnik/wiki/MacInstallation or ```brew install mapnik```
- Build environment: [Xcode](https://developer.apple.com/xcode/)

On Linux:
- https://github.com/mapnik/mapnik/wiki/LinuxInstallation
- Build environment: [gcc](https://help.ubuntu.com/community/InstallingCompilers) or clang

## Installation

Install from the latest tagged release:
```
$ gem install simple_mapnik
```

Or, add it to the Gemfile of an existing project:
```
gem 'simple_mapnik'
```

Then run:
```
$ bundle install
```

## Usage

Open an IRB session, or run `bin/mapnik_console`:

```ruby
require './lib/simple_mapnik' # not necessary if using bin/mapnik_console

SimpleMapnik.register_datasources '/usr/local/lib/mapnik/input'

map = SimpleMapnik::Map.new 256, 256
map.load 'spec/fixtures/sample/stylesheet.xml'
map.zoom_all
map.to_file '~/Desktop/sample_output.png'
```

## Testing

```
$ bundle install
$ rake spec
```

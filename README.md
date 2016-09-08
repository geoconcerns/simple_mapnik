SimpleMapnik
==========
[![Build Status](https://travis-ci.org/geoconcerns/simple_mapnik.svg)](https://travis-ci.org/geoconcerns/simple_mapnik)
[![Coverage Status](https://coveralls.io/repos/github/geoconcerns/simple_mapnik/badge.svg?branch=master)](https://coveralls.io/github/geoconcerns/simple_mapnik?branch=master)
[![Gem Version](https://img.shields.io/gem/v/simple_mapnik.svg)](https://github.com/geoconcerns/simple_mapnik/releases)

Simple ruby access to the Mapnik library using [ruby-ffi](https://github.com/ffi/ffi) and [mapnik-c-api](https://github.com/springmeyer/mapnik-c-api). Adapted from [ffi-mapnik](https://github.com/scooterw/ffi-mapnik).

## Prerequisites

SimpleMapnik requires that Mapnik 3.x or 2.x be installed at `/usr/local/lib/libmapnik.*`. The gem comes with a pre-built c api library compiled on OSX 10.10.5. For linux a C++ compiler and build environment is needed. 

If the OSX binary does not work, the library can be compiled (after installing a build environment) by running: 

``` 
$ rake api:build 
```

Mac OS X:

- https://github.com/mapnik/mapnik/wiki/MacInstallation or ```brew install mapnik```
- Build environment: [Xcode](https://developer.apple.com/xcode/)

Linux:

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

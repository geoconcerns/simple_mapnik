ffi-mapnik
==========
... mapnik from Ruby

NOTE: Mapnik must be installed to /usr/local/lib/libmapnik.*

NOTE: Uses https://github.com/springmeyer/mapnik-c-api (libmapnik_c.dylib compiled on OSX 10.10.3 included in repository)

NOTE: All development has been on Mac, and no testing has been done on other OSes to this point

To open IRB session with ffi-mapnik already loaded: `bin/mapnik_console`

```ruby
require './lib/ffi-mapnik' # not necessary if using bin/mapnik_console
# => true
map = Mapnik::Map.new 256, 256
# => #<Mapnik::Map:0x007f825aaac4c0 @width=256, @height=256, @ptr=#<FFI::AutoPointer address=0x007f8259f07ea0>>
Mapnik.register_datasources '/usr/local/lib/mapnik/input'
# => 0
map.load '/path/to/stylesheet.xml'
# => 0
map.zoom_all
# => 0
map.to_file '~/Desktop/sample_output.png'
# => 0
```


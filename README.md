# Catscan ~ A Catscanner for your Rails apps!


## Installation

Add this line to your application's Gemfile:

    gem 'catscan'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install catscan

## API Summary

The scanner can be wrapped within a convenience module for usage within
other modules or, for example, say in a `rake` task.

```ruby
require 'catscan'

namespace :foo do
  task :my_task => :environment do

    module RakeScanner
      include Catscan::Scannable
    end

    RakeScanner.scan(#...)

  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

This project rocks and uses MIT-LICENSE.

# Catscan

**A Catscanner for your Rails apps!** &mdash; allows you to 'scan' through your codebase by hooking into [Rails's `ActiveSupport::Notifications` API](http://api.rubyonrails.org/classes/ActiveSupport/Notifications.html).

## Installation

Add this line to your application's Gemfile:

    gem 'catscan'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install catscan

Finally, install and run migrations:

    $ rake catscan:install:migrations
    $ rake db:migrate

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

Within classes, simply include the `Scannable` mixin which will setup
`scan` as a class method, i.e. `Client.scan`.  In the following example,
a call to `Client.first.name` would `scan` and persist the `:name`
attribute of `Client`.

```ruby
class Client
  include Catscan::Scannable

  def name
    scan self, "#{name}", "Name, of the client", :client
    @name
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

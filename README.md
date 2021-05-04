## Shotgunner

![Gem](https://img.shields.io/gem/dt/shotgunner.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/nucleom42/shotgunner.svg)
![Gem](https://img.shields.io/gem/v/shotgunner.svg)

**Problem:**

* If there is a necessity to fetch data from external APIs. And it is expected to be a long way, because of quantity of links needed to be obtained.

**Solution:**

1. Define options for parallel call
2. Yield api caller into the run method.
3. Get your data up to 3 times faster than traditional queueing approach of fetching.
4. Use assembled result's array that keeps original order

**Notes:**

Calls performed based on thread pooling. Result data is unsorted.

## Install

```ruby

gem install shotgunner

```
## Examples

```ruby

class Service
  include Shotgunner::Parallel

  class << self
    def some_cool_logic
      urls_to_be_fetched = [URI('http://example.com/index.html?page=1'),
                            URI('http://example.com/index.html?page=2'),
                            URI('http://example.com/index.html?page=3')]
      
      data = run tasks: urls_to_be_fetched, threads: 6 do |uri|
        Net::HTTP.get(uri)
      end

      ## do everything you need with received data array
      data.map { |j| JSON.parse(j) }
    end
  end
end

```
## Shotgunner

![Gem](https://img.shields.io/gem/dt/shotgunner.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/nucleom42/shotgunner.svg)
![Gem](https://img.shields.io/gem/v/shotgunner.svg)

1. Define options for parallel call
2. Yield api caller into the run method.
3. Enjoy shotgun's unstoppable performance of retrieving data :)
4. Use assembled result's array.

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
      urls_to_be_fetched = [URI('http://example.com/index.html?count=10'),
                            URI('http://example.com/index.html?count=20')]
      
      data = run tasks: urls_to_be_fetched, threads: 6 do |uri|
        Net::HTTP.get(uri)
      end

      ## do everything you need with received data array
      data.map { |j| JSON.parse(j) }

    end
  end
end

```
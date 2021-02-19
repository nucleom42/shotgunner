## Shotgunner
![Gem](https://img.shields.io/gem/dt/shotgunner.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/shotgunner.svg)
![Gem](https://img.shields.io/gem/v/shotgunner.svg)

1. Define options for parallel call
2. Yield api caller into the run method.
3. Enjoy shotgun's unstoppable performance :)

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
      urls_to_be_fetched = [URI('http://example.com/index.html?count=10'), URI('http://example.com/index.html?count=20')]
      run tasks: urls_to_be_fetched, threads: 6 do |uri|
        Net::HTTP.get(uri)
      end
    end
  end
end

```
## Shotgunner
![Gem]()
![GitHub last commit]()
![Gem]()

1. Define options for parallel call
2. Yield api caller into the run method.
3. Enjoy shotgun's performance :)

## Install

```ruby
gem install shotgunner
```
## Examples

```ruby
class Service
  include Shotgunner

  class << self
    def some_cool_logic
      urls_to_be_fetched = %w[https//service.com?rate=EUR&rate=USD https//service.com?rate=USD&rate=EUR]
      Parallel::run threads: 6, tasks: urls_to_be_fetched do
        Net::HTTP.get(url)
      end
    end
  end
end
```
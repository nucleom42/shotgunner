## Shotgunner

![Gem](https://img.shields.io/gem/dt/shotgunner.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/nucleom42/shotgunner.svg)
![Gem](https://img.shields.io/gem/v/shotgunner.svg)

**Problem:**

** If there is a necessity to fetch data from external APIs consequently or perform time cost operation.

**Solution:**

* Use 'pmap' method instead 'map' and get fantastic performance boost just out of the box!
* Or use it this with native run method:
  1. Define options for parallel call
  2. Yield api caller into the 'run' method.
  3. Use assembled result's array that keeps original order

**Notes:**

* Calls performed based on thread pooling. 
* Since 0.1.5 result data keeps original order given from the tasks array.
* Since 1.0.1 presented traditional map approach which utilize same library.
'pmap' method appears in the array object.

## Install

```ruby

gem install shotgunner

```

## Rails

```ruby

gem 'shotgunner', require: %w[shotgunner/parallel array]

```

## Examples

```ruby

class Service
  include Shotgunner::Parallel

  class << self
    def some_cool_logic
      urls_to_be_fetched =
        [URI('http://example.com/index.html?page=1'),
         URI('http://example.com/index.html?page=2'),
         URI('http://example.com/index.html?page=3')]

      ## pmap instead map
      data = urls_to_be_fetched.pmap do |uri|
        JSON.parse(Net::HTTP.get(uri))
      end
      
      ## native approach
      data = run tasks: urls_to_be_fetched, threads: 6 do |uri|
        Net::HTTP.get(uri)
      end
      
      data.map { |j| JSON.parse(j) }
    end
  end
end

# execution time test pmap
pry(main)> start_time = Time.now
pry(main)> [1,2,3,4].pmap{|i| sleep(1); i}
pry(main)> pp Time.now - start_time

=> 1.002188

# execution time test map
pry(main)> start_time = Time.now
pry(main)> [1,2,3,4].map{|i| sleep(1); i}
pry(main)> pp Time.now - start_time

=> 4.018127
```
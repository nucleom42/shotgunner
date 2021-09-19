class Array
  include Shotgunner::Parallel
  
  def pmap(options = {})
    run(tasks: self, **options){ |item| yield(item) }
  end
end

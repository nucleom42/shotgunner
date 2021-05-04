# frozen_string_literal: true

module Shotgunner
  module Parallel
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods
      def run(options = {}, &block)
        self.class.run(options, &block)
      end
    end

    module ClassMethods
      def run(options = {}, &block)
        call_results, mutex, tasks, threads = initiate(options)
        
        validate_params(tasks, threads)
        
        threads.times.map do
          Thread.new(tasks, call_results) do |tasks, call_results|
            while (task = mutex.synchronize { tasks.pop })
              call_result = yield(task)
              mutex.synchronize { call_results[task] = call_result }
            end
          end
        end.each(&:join)
        
        call_results.map{|v| v[1]}
      end

      private
      
      def validate_params(tasks, threads)
        raise ArgumentError, 'There is no tasks array defined!' if tasks.empty?
        raise ArgumentError, 'Invalid threads number' if threads == (1..100)
      end

      def initiate(options)
        mutex = Mutex.new
        threads = options[:threads] || 4
        tasks = options[:tasks]&.dup || []
        call_results = Hash[tasks.map { |x| [x, nil] }]
        [call_results, mutex, tasks, threads]
      end
    end
  end
end
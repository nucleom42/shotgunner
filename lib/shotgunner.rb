# frozen_string_literal: true

module Shotgunner
  module Parallel
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods
      def run(options = {}, &block)
        self.class.call(options, &block)
      end
    end

    module ClassMethods
      def run(options = {}, &block)
        mutex = Mutex.new
        threads = options[:threads] || 4
        tasks = options[:tasks] || []
        raise ArgumentError, 'There is no tasks array defined!' if tasks.empty?
        call_results = []
        threads.times.map do
          Thread.new(tasks, call_results) do |tasks, call_results|
            while (task = mutex.synchronize { tasks.pop })
              call_result = yield(task)
              mutex.synchronize { call_results << call_result }
            end
          end
        end.each(&:join)
        call_results
      end
    end
  end
end
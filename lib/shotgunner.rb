# frozen_string_literal: true

module Shotgunner
  class Parallel
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:set_defaults)
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
        call_results = []
        threads.times.map do
          Thread.new(tasks, call_results) do |tasks, call_results|
            while (task = mutex.synchronize { tasks.pop })
              call_result = yield(task)
              mutex.synchronize { call_results << call_result }
            end
          end.each(&:join)
        end
        call_results
      end
    end
  end
end
# frozen_string_literal: true

require 'spec_helper'
require 'net/http'

describe Shotgunner::Parallel do
  let(:klass) { Class.new { include Shotgunner::Parallel } }
  let(:object) { klass.new }

  describe 'instance methods' do
    describe '#run' do
      it 'responds to the method' do
        expect(object).to respond_to(:run)
      end

      context 'when run with tasks array' do
        let(:tasks_array) do
          [URI('https://jsonplaceholder.typicode.com/posts/1'), URI('https://jsonplaceholder.typicode.com/posts/2')]
        end

        it 'returns result array' do
          expect(object.run(tasks: tasks_array){ |uri| Net::HTTP::get(uri) }.count).to eq 2
        end

        it 'keeps original order' do
          expect(klass.run(tasks: tasks_array){ |uri| Net::HTTP::get(uri) }
                   .map{|s| JSON.parse(s)}.map{|h| h["id"]}).to eq [1, 2]
        end

        it 'keeps tasks_array' do
          expect { object.run(tasks: tasks_array){ |uri| Net::HTTP::get(uri) } }
            .not_to change(tasks_array, :count)
        end

        it 'runs in parallel' do
          #TODO
        end
      end
    end
  end

  describe 'class methods' do
    describe '#run' do

      it 'responds to the method' do
        expect(klass).to respond_to(:run)
      end

      context 'when run with tasks array' do
        let(:tasks_array) do
          [URI('https://jsonplaceholder.typicode.com/posts/1'), URI('https://jsonplaceholder.typicode.com/posts/2')]
        end 
        
        it 'returns result array' do
          expect(klass.run(tasks: tasks_array){ |uri| Net::HTTP::get(uri) }.count).to eq 2
        end
        
        it 'keeps original order' do
          expect(klass.run(tasks: tasks_array){ |uri| Net::HTTP::get(uri) }
                   .map{|s| JSON.parse(s)}.map{|h| h["id"]}).to eq [1, 2]
        end
        
        it 'keeps tasks_array' do
          expect { klass.run(tasks: tasks_array){ |uri| Net::HTTP::get(uri) } }
            .not_to change(tasks_array, :count)
        end
        
        it 'runs in parallel' do
          #TODO
        end
      end
      
      context 'when run with options' do
        #TODO
      end
    end
  end
end

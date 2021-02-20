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
          [URI('http://example.com/index.html?count=10'), URI('http://example.com/index.html?count=20')]
        end

        it 'returns result array' do
          expect(object.run(tasks: tasks_array){ |uri| Net::HTTP::get(uri) }.count).to eq 2
        end

        it 'pull out tasks_array' do
          expect { object.run(tasks: tasks_array){ |uri| Net::HTTP::get(uri) } }
            .to change(tasks_array, :count).from(2).to(0)
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
          [URI('http://example.com/index.html?count=10'), URI('http://example.com/index.html?count=20')]
        end 
        
        it 'returns result array' do
          expect(klass.run(tasks: tasks_array){ |uri| Net::HTTP::get(uri) }.count).to eq 2
        end
        
        it 'pull out tasks_array' do
          expect { klass.run(tasks: tasks_array){ |uri| Net::HTTP::get(uri) } }
            .to change(tasks_array, :count).from(2).to(0)
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

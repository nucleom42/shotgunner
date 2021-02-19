# frozen_string_literal: true

require 'spec_helper'

describe Shotgunner::Parallel do
  let(:klass) { Class.new { include Shotgunner } }
  let(:object) { klass.new }

  describe 'instance methods' do
    describe '#Parallel.run' do
      it 'responds to the method' do
        #TODO
      end
    end
  end

  describe 'class methods' do
    describe '#run' do

      it 'responds to the method' do
        #TODO
      end

      context 'when run without options' do
        #TODO
      end
      context 'when run with options' do
        #TODO
      end
    end
  end
end

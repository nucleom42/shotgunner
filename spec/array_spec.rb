# frozen_string_literal: true

require 'spec_helper'
require 'net/http'

describe Array do
  describe '#instance methods' do
    describe '#pmap' do
      context 'when' do
        let(:tasks_array) do
          [URI('https://jsonplaceholder.typicode.com/posts/1'), URI('https://jsonplaceholder.typicode.com/posts/2')]
        end
        
        it 'assembles parsed array in a parallel way' do
          expect(tasks_array.pmap { |uri| JSON.parse(Net::HTTP::get(uri)) }).to eq [{"userId"=>1, "id"=>1, "title"=>"sunt aut facere repellat provident occaecati excepturi optio reprehenderit", "body"=>"quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"},
                                                                                    {"userId"=>1, "id"=>2, "title"=>"qui est esse", "body"=>"est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"}]
        end
      end
    end
  end
end


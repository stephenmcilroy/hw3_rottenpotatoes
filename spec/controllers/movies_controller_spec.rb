require 'spec_helper'

describe MoviesController do
  describe 'Find Movies With Same Director' do
    it 'should call method to search Movie DB for Same Director' do
      post :find_movies_with_same_director, {:search_terms => 'adirector'}
    end
    it 'should select the index template for rendering' do
      
    end
    it 'should pass the search result to the index view'
  end
end
    
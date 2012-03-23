require 'spec_helper'

describe MoviesController do
  describe 'Find Movies With Same Director' do
    before :each do
       @fake_results = [mock('Movie'), mock('Movie')]
       @fake_movie = mock('Movie',:director => 'adirector')
    end
    it 'should call method to search Movie DB for Same Director' do
      Movie.should_receive(:find_by_title).with('atitle').
        and_return(@fake_movie)
      Movie.should_receive(:find_all_by_director).with('adirector').
       and_return(@fake_results)
      post :similar_movies, {:title => 'atitle'}
    end
    describe 'after a valid search' do
      before :each do
        Movie.stub(:find_by_title).and_return(@fake_movie)
        Movie.stub(:find_all_by_director).
          and_return(@fake_results)
        post :similar_movies, {:title => 'atitle'}
      end
      it 'should select the template for rendering' do
        response.should render_template('similar_movies')
      end
      it 'should pass the search result to the view' do
        assigns(:movies).should == @fake_results
      end
    end
  end
  describe 'Find Movies With Same Director when no director exists' do
    before :each do
      @fake_movie = mock('Movie',:director => '', :title => 'atitle')
    end
    it 'should call method to search Movie DB by title for Director' do
      Movie.should_receive(:find_by_title).with('atitle').
        and_return(@fake_movie)
      post :similar_movies, {:title => 'atitle'}
    end
    describe 'after a no director search' do
      before :each do
        Movie.stub(:find_by_title).and_return(@fake_movie)
        post :similar_movies, {:title => 'atitle'}
      end
      it 'should flash specific notice' do
        flash[:notice].should eql "'atitle' has no director info"  
      end
      it 'should redirect to the home page' do
        response.should redirect_to movies_path
      end
    end
  end
end
    
require "test_helper"

describe Movie do
  describe "relations" do
    before do
      @movie1 = movies(:Jaws)
      @movie2 = movies(:Goonies)
    end

    it "a movie can have a many customers" do
      @movie1.must_respond_to :customers
    end

    it "a movie can have zero customers" do
      Rental.destroy_all
      @movie1.must_respond_to :customers
    end

    it "a movie can have many rentals" do
      @movie1.must_respond_to :rentals
    end

    it "a movie can have zero rentals" do
      Rental.destroy_all
      @movie1.must_respond_to :rentals
    end

  end
  describe 'validations' do
    before do
      @movie1 = Movie.new(title: 'new movie',  overview: 'something@email.com', release_date: '01/01/1970', inventory: 99)
    end

    it 'allows a new movie to be created' do
      @movie1.save
      @movie1.must_be :valid?
    end

    it 'must have a title' do
      @movie1.title = nil
      @movie1.wont_be :valid?
    end

    it 'must have a overview' do
      @movie1.overview = nil
      @movie1.wont_be :valid?
    end

    it 'must have a release_date' do
      @movie1.release_date = nil
      @movie1.wont_be :valid?
    end

    it 'must have a inventory' do
      @movie1.inventory = nil
      @movie1.wont_be :valid?
    end
  end

  describe "index" do
    it "gets index" do
      get movies_path
      must_respond_with :ok
    end
  end

  describe "show" do
    it "gets a valid movie" do
      params = {
        id: Movie.first.id
      }
      get movie_path(params)
      must_respond_with :ok
    end

    it "throws error for valid movie id" do
      id = Movie.last.id +1
      params = {
        id: id
      }
      get movie_path(params)
      must_respond_with :not_found
    end
  end

  describe "create" do
    it "creates a movie with valid params" do
      params = {
        title: "awesome movie 1",
        overview: "awesome movie about awesome people",
        release_date: "2018-10-10",
        inventory: "5"
      }

      post movies_path, params: params
      must_respond_with :ok
    end

    it "does not create movie with bad params" do
      params = {
        release_date: "2018-10-10",
        inventory: "5"
      }

      post movies_path, params: parmas
      must_respond_with :bad_request
    end
  end
end

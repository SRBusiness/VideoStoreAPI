class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :id, presence: true
  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true


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


      describe 'validations' do
        before do
          @movie1 = Movie.new(title: 'new movie',  overview: 'something@email.com', release_date: '01/01/1970', inventory: 99)
        end

        it 'allows a new movie to be created' do
          @movie1.must_be :valid?
        end

        it 'must have a title' do
          @movie1.title = nil
          @movie1 wont_be :valid?
        end

        it 'must have a overview' do
          @movie1.overview = nil
          @movie1 wont_be :valid?
        end

        it 'must have a release_date' do
          @movie1.release_date = nil
          @movie1 wont_be :valid?
        end

        it 'must have a inventory' do
          @movie1.inventory = nil
          @movie1 wont_be :valid?
        end
    end

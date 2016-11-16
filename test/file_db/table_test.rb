require 'test_helper'

class FileDb::TableTest < Minitest::Test

  def setup
    @db = FileDb::Database.new('fixtures/data.json')
    @movies = @db.table('movies')
    @directors = @db.table('directors')
  end

  def test_select_with_id
    assert_equal(@movies.select(where: { id: 1 })[:title], 'The Gold Rush')
  end

  def test_select_with_year
    assert_equal(@movies.select(where: { year: '1936' })[:title], 'Modern Times')
  end

end

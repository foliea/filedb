require 'test_helper'

class FileDb::TableTest < Minitest::Test

  def setup
    @db = FileDb::Database.new('fixtures/data.json')
    @movies = @db.table('movies')
    @directors = @db.table('directors')
  end

  def test_select_with_id
    assert_equal(@movies.select(where: { id: 1 }).first[:title], 'The Gold Rush')
  end

  def test_select_with_year
    assert_equal(@movies.select(where: { year: 1936 }).first[:title], 'Modern Times')
  end

  def test_delete_with_id
    search = { where: { id: 1 } }

    @movies.delete(search)

    assert_equal(@movies.select(search), [])
  end

  def test_delete_with_year
    search = { where: { year: 1936 } }

    @movies.delete(search)

    assert_equal(@movies.select(search), [])
  end

  def test_update_with_values
    search = { id: 6 }
    values = { year: 1963 }

    @movies.update(where: search, values: values)

    assert_equal(@movies.select(where: search.merge(values)).count, 1)
  end

  def test_insert_record_with_attributes
    attributes = { title: 'Birds', year: 1962, director_id: 2 }

    @movies.insert(attributes)

    assert_equal(@movies.select(where: attributes).count, 1)
  end

  def test_insert_record_with_incremental_id
    expected_id = @movies.select.map { |r| r[:id] }.max + 1

    attributes = { title: 'Lol', year: 1964, director_id: 2 }

    @movies.insert(attributes)

    assert_equal(@movies.select(where: attributes).first[:id], expected_id)
  end
end

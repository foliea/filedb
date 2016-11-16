module FileDb
  class Table

    def initialize(rows)
      @rows = rows.map { |row| symbolize_hash(row) }
    end

    def select(where: {})
      @rows.select { |row| row.values_at(*where.keys) == where.values }
    end

    def insert(row)
      @rows << symbolize_hash(row.merge(id: next_id))
    end

    def update(where: {}, values: {})
      select(where: where).each do |row|
        row.merge!(values)
      end
    end

    def delete(where: {})
      @rows -= select(where: where)
    end

    private

    def next_id
      @max_id ||= @rows.map { |e| e[:id] }.max
      @max_id = @max_id + 1
    end

    def symbolize_hash(hash)
      hash.inject({}) do |memo, (k, v)|
        v = symbolize_hash(v) if v.is_a?(Hash)
        memo[k.to_sym] = v
        memo
      end
    end

  end
end

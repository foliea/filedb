module FileDb
  class Table

    def initialize(rows)
      @rows = symbolize_hash(rows)
    end

    def select(where:)
      @rows.select { |row| row.values_at(*where.keys) == where.values }
    end

    def insert(row)
      @rows << symbolize_hash(row.merge(id: next_id))
    end

    private

    def next_id
      @max_id ||= @rows.map { |e| e.id }.sort { |a, b| b <=> a }.first
      @max_id = @max_id + 1
    end

    def symbolize_hash(rows)
      rows.map do |line|
        line.inject({}) do |memo, (k, v)|
          v = symbolize_hash(v) if v.is_a?(Hash)
          memo[k.to_sym] = v
          memo
        end
      end
    end

  end
end

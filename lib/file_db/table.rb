module FileDb
  class Table
    def initialize(rows)
      @rows = rows
    end

    def select(where:)
      rows_symbolized.select do |row|
        row.values_at(*where.keys) == where.values
      end
    end

    def insert(object)
      @rows << object.merge(id: next_id)
    end

    private

    def rows_symbolized
      @rows_symbolized ||= @rows.map do |line|
        line.inject({}) do |memo,(k,v)|
          memo[k.to_sym] = v
          memo
        end
      end
    end

    def next_id
      @max_id ||= @rows.map { |e| e.id }.sort { |a, b| b <=> a }.first
      @max_id = @max_id + 1
    end
  end
end

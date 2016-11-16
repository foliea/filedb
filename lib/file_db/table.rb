module FileDb
  class Table

    def initialize(internal)
      @internal = internal
    end

    def insert(object)
      @internal << object.merge(id: next_id))
    end

    private

    def next_id
      @max_id ||= @internal.map { |e| e.id }.sort { |a, b| b <=> a }.first
      @max_id = @max_id + 1
    end

  end
end

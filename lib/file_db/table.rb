module FileDb
  class Table

    def initialize(internal)
      @internal = internal
    end

    def insert(object)
      @internal << object.merge(id: get_id_and_increment))
    end

    private

    def get_id_and_increment
      @max_id ||= @internal.map { |e| e.id }.sort { |a, b| b <=> a }.first
      @max_id = @max_id + 1
    end

  end
end

require 'json'

module FileDb
  class Database
    def initialize(data_file)
      @internal = JSON.parse(IO.read(data_file))
    end

    def table_names
      @internal.keys.sort
    end

    def table(table_name)
      Table.new(@internal[table_name])
    end
  end
end

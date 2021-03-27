class Pokemon

    attr_accessor :name, :type, :db, :id

    def initialize(id: nil, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db_conn)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL

        db_conn.execute(sql, name, type)
    end

    def self.find(id, db_conn)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
        SQL

        poke = db_conn.execute(sql, id).flatten
        name = poke[1]
        type = poke[2]
        Pokemon.new(id: id, name: name, type: type, db: db_conn)
    end
end

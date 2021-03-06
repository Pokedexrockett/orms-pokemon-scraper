class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
         INSERT INTO pokemon(name, type)
         VALUES (?, ?)
        SQL
        db.execute(sql, [name, type])
    end

    def new_from_db
        sql = <<-SQL
          SELECT *
          FROM pokemon
        SQL
    
        DB[:conn].execute(sql).map do |row|
          self.new_from_db(row)
        end
      end


    def self.find(id, db)
        sql = <<-SQL
        SELECT *
        FROM pokemon
        WHERE id = ?
        LIMIT 1
        SQL
    
        pokemon = db.execute(sql, id).map do |row|
            self.new_from_db(row)
          end.first

          
    end

    
    
end

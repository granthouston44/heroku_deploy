require_relative('../db/sql_runner')

class Tag

attr_reader :id
attr_accessor :tag_name

def initialize(tag_details)
  @id = tag_details['id'].to_i if tag_details['id']
  @tag_name = tag_details['tag_name'].capitalize
end

def self.delete_all
  sql = "DELETE FROM tags"
  SqlRunner.run(sql)
end

def save
  sql =
  "
  INSERT INTO tags
  (tag_name)
  VALUES ($1)
  RETURNING id
  "
  values = [@tag_name]
  tag = SqlRunner.run(sql, values)
  @id = tag.first['id'].to_i
end

def update
  sql =
  "
  UPDATE tags
  SET tag_name =
  $1
  WHERE id = $2
  "
  values = [@tag_name, @id]
  SqlRunner.run(sql, values)
end

def self.all()
  sql =
  "
  SELECT * FROM tags;
  "
  tags = SqlRunner.run(sql)
  return tags.map {|tag| Tag.new(tag)}
end

def self.delete(id)
  sql =
  "
  DELETE FROM tags
  WHERE id = $1
  "
  values = [id]
  SqlRunner.run(sql, values)
end

def self.find(id)
  sql =
  "
  SELECT * FROM tags
  WHERE id = $1
  "
  values = [id]
  merchants = SqlRunner.run(sql,values).first
  return Tag.new(merchants)
end

end

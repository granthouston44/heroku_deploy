require_relative('../db/sql_runner')

class Tag

attr_reader :id
attr_accessor :name

def initialize(tag_details)
  @id = tag_details['id'].to_i if tag_details['id']
  @name = tag_details['name']
end


end

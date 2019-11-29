require('minitest/autorun')
require('minitest/reporters')
require_relative('../models/tag')

MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

class TagTest < MiniTest::Test

def test_can_create_tag_object
Tag.new({
  'name' => 'games'
  })
end

end

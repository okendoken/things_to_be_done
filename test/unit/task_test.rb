require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "should save task if project_id is set" do
    u = User.create!(:email => 'test5@example.com', :password => 'test123', :nickname => 'First User')
    t = Task.new(:title => 'Promote TTBD',
                 :description => "Seems that TTBD will become popular by its own, but we have to put efforts to make it happen")
    assert t.save
  end
end

u = User.create!(:email => 'test@example.com', :password => 'test123', :nickname => 'First User')
problem = Problem.create!(:user => u, :title => 'There are many problems in the World',
                          :description => "If we won't make world better it'll be getting worse")
p = Project.create!(:user => u, :title => 'Make world better',
                    :description => "We have to move world forward by making it better and solving problems",
                    :problem => problem)
t1 = Task.create!(:project => p, :user => u, :title => 'Complete TTBD',
                  :description => "We have six reasons why we have to complete TTBD:\n
                  1. we'll feel better. we'll be able to say 'we've built company!'\n
                  2. we'll have money\n
                  3. we'll make world better\n
                  4. feeling of justice is very strong among us. there are so many unjustice around.\n
                  5*. TTBD is really focused. We see it future. The future is TTBD.\n
                  6*. Paul Graham said he is going to invest in such kind of projects")
t2 = Task.create!(:project => p, :user => u, :title => 'Promote TTBD',
                  :description => "Seems that TTBD will become popular by its own,
but we have to put efforts to make it happen")

t3 = Task.create!(:project => p, :user => u, :title => 'Big description',
                  :description => "test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test test test test test test test test test test test test test test test test test test test test
test test")

t1.vote_for_this(u)
t2.vote_for_this(u)
p.vote_for_this(u)

t1.participate_in_this(u)
t2.participate_in_this(u)

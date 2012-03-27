module RatingEnvironment

  def change_related_rating(reason, reason_type)
    clazz = reason.class.name.downcase.to_sym
    RATING_HANDLERS[clazz][reason_type].call(reason) if RATING_HANDLERS[clazz][reason_type].present?
  end

  private

  SQL = <<-SQL
    rating = rating +
    (select abs(vp - vn) * vp / (vp + vn) * %{factor} as rating from (
              select
                      (select count(*) from votes where positive = 't') as vp,
                      (select count(*) from votes where positive = 'f') as vn
            )
    )
  SQL

  RATING_HANDLERS = {
      :vote => {
          true => Proc.new{ |vote|
            user = vote.target.user
            user.rating += 1
            user.save
          }
      },
      :project => {
          :completed => Proc.new{ |project|
            project.participants.update_all SQL % {:factor => 3}
          }
      },
      :task => {
          :completed => Proc.new{ |task|
            task.participants.update_all SQL % {:factor => 3}
          }
      },
      :participation => {
          :added => Proc.new{ |participation|
            User.update_all SQL % {:factor => 1}, :id => participation.task.user.id
          }
      },
      :activity => {
          :completed => Proc.new{ |activity|
            User.update_all SQL % {:factor => 2}, :id => activity.user.id
          }
      }
  }


end
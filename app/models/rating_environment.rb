module RatingEnvironment

  def change_related_rating(reason, reason_type)
    clazz = reason.class.name.downcase.to_sym
    RATING_HANDLERS[clazz][reason_type].call(reason) if RATING_HANDLERS[clazz][reason_type].present?
  end

  private

  SQL = <<-SQL
    rating = rating +
    ifnull((select abs(vp - vn) * vp / (vp + vn) * %{factor} as rating from (
              select
                      (select count(*) from votes where positive = 't'
                                        and target_type = '%{target_type}'
                                        and target_id = %{target_id}) as vp,
                      (select count(*) from votes where positive = 'f'
                                        and target_type = '%{target_type}'
                                        and target_id = %{target_id}) as vn
            )
    ),0)
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
            project.participants.update_all SQL % {:factor => 3,
                                                   :target_id => project.id,
                                                   :target_type => project.class.name}
          }
      },
      :task => {
          :completed => Proc.new{ |task|
            task.participants.update_all SQL % {:factor => 3,
                                                :target_id => task.id,
                                                :target_type => task.class.name}
          }
      },
      :participation => {
          :added => Proc.new{ |participation|
            User.update_all SQL % {:factor => 1,
                                   :target_id => participation.id,
                                   :target_type => participation.class.name}, :id => participation.task.user.id
          }
      },
      :activity => {
          :completed => Proc.new{ |activity|
            User.update_all SQL % {:factor => 2,
                                   :target_id => activity.id,
                                   :target_type => activity.class.name}, :id => activity.user.id
          }
      }
  }
end
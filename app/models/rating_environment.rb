module RatingEnvironment

  def change_related_rating(reason, reason_type)
    clazz = reason.class.name.downcase.to_sym
    RATING_HANDLERS[clazz][reason_type].call(reason)
  end

  private

  RATING_HANDLERS = {
      :vote => {
          true => Proc.new{ |vote|
            user = vote.user
            user.rating += 1
            user.save
          }
      },
      :project => {
          :completed => Proc.new{ |project|
            #project.participants.plunk
          }
      },
      :task => {
          #:completed => Proc.new{|task| [task, task.project] + task.participants}
      },
      :participation => {
          #somebody participated. notify parent-task, task-author
          #:added => Proc.new{|participation| [participation.task, participation.task.user, participation.task.project]}
      },
      :activity => {
          #:completed => Proc.new{|activity| [activity.participation.task, activity.participation.task.project, activity.participation.task.user]}
      }
  }


end
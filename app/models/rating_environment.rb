module RatingEnvironment

  def change_related_rating(reason, reason_type)
    clazz = reason.class.name.downcase.to_sym
    #todo
    RATING_HANDLERS[clazz][reason_type].call(reason)
  end

  private

  RATING_HANDLERS = {
      :vote => {
          true => Proc.new{|vote| [vote.target.user]}
      },
      :project => {
          :completed => Proc.new{|project| [project] + project.participants}
      },
      :task => {
          :completed => Proc.new{|task| [task, task.project] + task.participants}
      },
      :participation => {
          #somebody participated. notify parent-task, task-author
          :added => Proc.new{|participation| [participation.task, participation.task.user, participation.task.project]},
          :completed => Proc.new{|participation| [participation.task, participation.task.user, participation.task.project]},
          :canceled => Proc.new{|participation| [participation.task, participation.task.user, participation.task.project]}
      },
      :comment => {
          :added => Proc.new{|comment| [comment.target, comment.target.user]}
      },
      :activity => {
          :added => Proc.new{|activity| [activity.participation.task, activity.participation.task.project, activity.participation.task.user]}
      }
  }


end
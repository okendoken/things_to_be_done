module EventEnvironment
  #what guys should be notified when something happened
  # format: stuff_to_process/event_type
  EVENT_READERS = {
      :project => {
          :completed => Proc.new{|project| [project] + project.participants},
          :canceled => Proc.new{|project| [project] + project.participants},
          :in_progress => Proc.new{|project| [project] + project.participants}
      },
      #task-related events
      :task => {
          #task has been completed. notify task, parent-project, task-author
          :completed => Proc.new{|task| [task, task.project] + task.participants},
          #etc
          :canceled => Proc.new{|task| [task, task.project, task.participants]},
          :in_progress => Proc.new{|task| [task, task.project] + task.participants}
      },
      :participation => {
          #somebody participated. notify parent-task, task-author
          :added => Proc.new{|participation| [participation.task, participation.task.user, participation.task.project]},
          :completed => Proc.new{|participation| [participation.task, participation.task.user, participation.task.project]},
          :canceled => Proc.new{|participation| [participation.task, participation.task.user, participation.task.project]}
      },
      :vote => {
          #notify only creator
          true => Proc.new{|vote| [vote.target.user]},
          false => Proc.new{|vote| [vote.target.user]}
      },
      :comment => {
          :added => Proc.new{|comment| [comment.target, comment.target.user]}
      },
      :activity => {
          :added => Proc.new{|activity| [activity.participation.task, activity.participation.task.project, activity.participation.task.user]}
      }
  }

  DB_EVENT_TYPES = {
      :project => {
          :completed => 0, :canceled => 1, :in_progress => 3
      },
      :task => {
          :completed => 0, :canceled => 1, :in_progress => 3
      },
      :participation => {
          :added => 10, :completed => 11, :canceled => 12
      },
      :vote => {
          #notify only creator
          true => 20,
          false => 21
      },
      :comment => {
          :added => 30
      },
      :activity => {
          :added => 40
      }
  }

  NEWS_TEMPLATES = {
      :project => {
          :completed => 'partials/stub',
          :canceled => 'partials/stub',
          :in_progress => 'partials/stub'
      },
      :task => {
          :completed => 'partials/stub',
          :canceled => 'partials/stub',
          :in_progress => 'partials/stub'
      },
      :participation => {
          :added => 'partials/news/participation',
          :canceled => 'partials/news/participation'
      },
      :vote => {
          #notify only creator
          true => 'partials/news/vote',
          false => 'partials/news/vote'
      },
      :comment => {
          :added => 'partials/news/comment'
      },
      :activity => {
          :added => 'partials/news/activity'
      }
  }

  NOTIFICATIONS_TEMPLATES = {
      :project => {
          :completed => 'partials/stub',
          :canceled => 'partials/stub',
          :in_progress => 'partials/stub'
      },
      :task => {
          :completed => 'partials/stub',
          :canceled => 'partials/stub',
          :in_progress => 'partials/stub'
      },
      :participation => {
          :added => 'partials/notifications/participation',
          :canceled => 'partials/news/participation'
      },
      :vote => {
          #notify only creator
          true => 'partials/notifications/vote',
          false => 'partials/notifications/vote'
      },
      :comment => {
          :added => 'partials/notifications/comment'
      },
      :activity => {
          :added => 'partials/stub'
      }
  }
end
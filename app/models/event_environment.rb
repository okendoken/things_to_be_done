module EventEnvironment
  #what guys should be notified when something happened
  # format: stuff_to_process/event_type
  EVENT_READERS = {
      #task-related events
      :task => {
          #task has been completed. notify task, parent-project, task-author
          :completed => Proc.new{|task| [task, task.project, task.user]},
          #etc
          :canceled => Proc.new{|task| [task, task.project, task.user]}
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
      }
  }

  DB_EVENT_TYPES = {
      :task => {
          :completed => 0, :canceled => 1
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
      }
  }

  NEWS_TEMPLATES = {
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
      }
  }

  NOTIFICATIONS_TEMPLATES = {
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
      }

  }
end
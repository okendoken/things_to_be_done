module EventEnvironment
  TASK_STATUS = {:in_progress => 1, :completed => 2, :canceled => 3}
  PARTICIPATION_STATUS = {:in_progress => 1, :completed => 2, :canceled => 3}

  #what guys should be notified when something happened
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
          :added => Proc.new{|participation| [participation.task, participation.task.user]},
          :completed => Proc.new{|participation| [participation.task, participation.task.user]},
          :canceled => Proc.new{|participation| [participation.task, participation.task.user]}
      }
  }

  DB_EVENT_TYPES = {
      :task => {
          :completed => 0, :canceled => 1
      },
      :participation => {
              :added => 10, :completed => 11, :canceled => 12
      }
  }

  NEWS_TEMPLATES = {:project => {:join => 'test.html', :another => 'adc.html'}}
  NOTIFICATIONS_TEMPLATES = {:project => {:join => 'notigication_test.html', :another => 'adc.html'}}
end
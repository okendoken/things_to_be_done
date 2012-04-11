module EventEnvironment
  #what guys should be notified when something happened
  # format: stuff_to_process/event_type
  EVENT_READERS = {
      :project => {
          :completed => Proc.new{|project| [project] + project.participants + UserInfo.where(:id => project.participants.pluck(:'users.id'))},
          :canceled => Proc.new{|project| [project] + project.participants + UserInfo.where(:id => project.participants.pluck(:'users.id'))},
          :in_progress => Proc.new{|project| [project] + project.participants + UserInfo.where(:id => project.participants.pluck(:'users.id'))}
      },
      #task-related events
      :task => {
          #task has been completed. notify task, parent-project, task-author
          :completed => Proc.new{|task| [task, task.project] + task.participants + UserInfo.where(:id => task.participants.pluck(:'users.id'))},
          #etc
          :canceled => Proc.new{|task| [task, task.project] + task.participants + UserInfo.where(:id => task.participants.pluck(:'users.id'))},
          :in_progress => Proc.new{|task| [task, task.project] + task.participants + UserInfo.where(:id => task.participants.pluck(:'users.id'))}
      },
      :participation => {
          #somebody participated. notify parent-task, task-author
          :added => Proc.new do |participation|
            [participation.task, participation.task.user, participation.task.user.user_info, participation.task.project] + UserInfo.where(:id => participation.task.participants.pluck(:'users.id'))
          end,
          :completed => Proc.new do |participation|
            [participation.task, participation.task.user, participation.task.user.user_info, participation.task.project] + UserInfo.where(:id => participation.task.participants.pluck(:'users.id'))
          end,
          :canceled => Proc.new do |participation|
            [participation.task, participation.task.user, participation.task.user.user_info, participation.task.project] + UserInfo.where(:id => participation.task.participants.pluck(:'users.id'))
          end
      },
      :vote => {
          #notify only creator
          true => Proc.new{|vote| [vote.target.user]},
          false => Proc.new{|vote| [vote.target.user]}
      },
      :comment => {
          :added => Proc.new do |comment|
            #for now target can be only task or project. when activity will be made commentable it will be needed to introduce class check
            [comment.target, comment.target.user] +  UserInfo.where(:id => comment.target.participants.pluck(:'users.id'))
          end
      },
      :activity => {
          :added => Proc.new do |activity|
            [activity.participation.task, activity.participation.task.project, activity.participation.task.user] + UserInfo.where(:id => activity.participation.task.project.participants.pluck(:'users.id'))
          end
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
          #TODO: define where resolve readable type. here(vote_for_activity = partial_vote_for activity) or on the view
          # like prepare_path approach)
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
          :completed => 'partials/news/project',
          :canceled => 'partials/news/project',
          :in_progress => 'partials/news/project'
      },
      :task => {
          :completed => 'partials/news/task',
          :canceled => 'partials/news/task',
          :in_progress => 'partials/news/task'
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
          :canceled => 'partials/notifications/participation'
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
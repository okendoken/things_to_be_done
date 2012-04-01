namespace :db do
  task :re do
    Rake::Task['db:drop'].invoke
    puts "done drop"
    Rake::Task['db:create'].invoke
    puts "done create"
    Rake::Task['db:migrate'].invoke
    puts "done migrate"
    Rake::Task['db:seed'].invoke
    puts "done seed"
  end
end
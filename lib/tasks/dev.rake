namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configures the development envrioment"
  task setup: :environment do
    if Rails.env.development?

    show_spinner("Droping Database...") {%x(rails db:drop)}
    show_spinner("Creating Database...") {%x(rails db:create)}
    show_spinner("Migrating Database...") {%x(rails db:migrate)}
    show_spinner("Populating Database...1/5") {%x(rails dev:populate_admin)}
    show_spinner("Populating Database...2/5") {%x(rails dev:populate_extra_admin)}
    show_spinner("Populating Database...3/5") { %x(rails dev:populate_user)}
    show_spinner("Populating Database...4/5") { %x(rails dev:populate_subjects) }
    show_spinner("Populating Database...5/5") { %x(rails dev:populate_answers_questions) }


    else
      puts "You are not in the development envrioment to run this!!"
    end
  end

  desc "Populate Admin's model in a basic level"
  task populate_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end
  
  
  desc "Populate Admin's using Faker Gem"
  task populate_extra_admin: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end  
  end

 
  desc "Populate User's model in a basic level"
  task populate_user: :environment do
    User.create!(
    email: 'user@user.com',
    password: DEFAULT_PASSWORD,
    password_confirmation: DEFAULT_PASSWORD
    )
  end

 desc "Populate Subject's model"
 task populate_subjects: :environment do
  file_name = 'subjects.txt'
  file_path = File.join(DEFAULT_FILES_PATH, file_name)

  File.open(file_path, 'r').each do |line|
  Subject.create!(description: line.strip)
  end
 end

 desc "populate Answers and Questions Model"
 task populate_answers_questions: :environment do
  Subject.all.each do |subject|
    rand(5..10).times do |i|
    Question.create!(
    description: "#{Faker::Lorem.paragraph} #{Faker::Lorem.question}",
    subject: subject
    )
    end
  end
 end

  private
  def show_spinner(msg_start)
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success('(task completed!)')
  end

end
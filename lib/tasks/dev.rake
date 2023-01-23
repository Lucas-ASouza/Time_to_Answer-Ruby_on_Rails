namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configures the development envrioment"
  task setup: :environment do
    if Rails.env.development?

    show_spinner("Droping Database...") {%x(rails db:drop)}
    show_spinner("Creating Database...") {%x(rails db:create)}
    show_spinner("Migrating Database...") {%x(rails db:migrate)}
    show_spinner("Populating Database...1/4") {%x(rails dev:populate_admin)}
    show_spinner("Populating Database...2/4") {%x(rails dev:populate_extra_admin)}
    show_spinner("Populating Database...3/4") { %x(rails dev:populate_user)}
    show_spinner("Populatint database...4/4") { %x(rails dev:add_subjects) }

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

  private
  def show_spinner(msg_start)
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success('(task completed!)')
  end

end
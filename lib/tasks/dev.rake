namespace :dev do

  DEFAULT_PASSWORD = 123456

  desc "Configures the development envrioment"
  task setup: :environment do
    if Rails.env.development?

    show_spinner("Droping Database...") {%x(rails db:drop)}
    show_spinner("Creating Database...") {%x(rails db:create)}
    show_spinner("Migrating Database...") {%x(rails db:migrate)}
    show_spinner("Populating Database...1/2") {%x(rails dev:populate_admin)}
    show_spinner("Populating Database...2/2") { %x(rails dev:populate_user)}



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
 
  desc "Populate User's model in a basic level"
  task populate_user: :environment do
  User.create!(
  email: 'user@user.com',
  password: DEFAULT_PASSWORD,
  password_confirmation: DEFAULT_PASSWORD
  )
  end


  private
  def show_spinner(msg_start)
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success('(task completed!)')
  end

end
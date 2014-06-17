namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(email: "emotionlab@fandm.edu",
                         password: "imauss06",
                         password_confirmation: "imauss06",
                         admin: true)

    5.times do |n|
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      User.create!(email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
User.create!(name:  "Test User",
  email: "test@mailto.plus",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

99.times do |n|
  name  = Faker::Name.name
  email = "test-#{n+1}@mailto.plus"
  password = "password"
  User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
  )
end

users = User.order(:created_at).take(6)
Faker::UniqueGenerator.clear
17.times do
  content = Faker::ChuckNorris.unique.fact
  users.each { |user| user.microposts.create!(content: content) }
end
Faker::UniqueGenerator.clear
15.times do
  content = Faker::TvShows::BojackHorseman.unique.quote
  users.each { |user| user.microposts.create!(content: content) }
end
Faker::UniqueGenerator.clear
6.times do
  content = Faker::TvShows::BojackHorseman.unique.tongue_twister
  users.each { |user| user.microposts.create!(content: content) }
end
Faker::UniqueGenerator.clear
User.create!(name:  "Test User",
  email: "test@mailto.plus",
  password:              "foobar",
  password_confirmation: "foobar",
  admin: true
)

99.times do |n|
name  = Faker::Name.name
email = "test-#{n+1}@mailto.plus"
password = "password"
User.create!(name:  name,
  email: email,
  password:              password,
  password_confirmation: password)
end
daemon = User.create(username: "daemon", password: "yumfood")
20.times do 
  Recipe.create(name: Faker::Food.dish, user: daemon)
end

zita = User.create(username: "zita", password: "123eat")
12.times do
  Recipe.create(name: Faker::Food.dish, user: zita)
end

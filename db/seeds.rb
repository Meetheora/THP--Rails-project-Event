puts "Création des utilisateurs..."
# using create! good practice to display clear console errors
User.create!(
  first_name: "John",
  last_name: "Doe",
  email: "boitedetestpourTHP@yopmail.com",
  password:"password123",
  password_confirmation: "password123",
  description: "Créateur d'événements passionné."
)

User.create!(
  first_name: "Steve",
  last_name: "Jobs",
  email: "boitedetestpourTHP2@yopmail.com",
  password:"password123",
  password_confirmation: "password123",
  description: "J'adore participer aux événements de ma ville !"
)

puts "Seed terminé !"
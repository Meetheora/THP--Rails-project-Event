puts "Création des utilisateurs..."
# using create! good practice to display clear console errors
User.create!(
  first_name: "John",
  last_name: "Doe",
  email: "john.doe@yopmail.com",
  encrypted_password: "password123", # will be modified with Devise
  description: "Créateur d'événements passionné."
)

User.create!(
  first_name: "Steve",
  last_name: "Jobs",
  email: "steve.jobs@yopmail.com",
  encrypted_password: "password123",
  description: "J'adore participer aux événements de ma ville !"
)

puts "Seed terminé !"
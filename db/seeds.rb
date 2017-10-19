if Admin.count != 1
  # Seed initial admin user
  User.create!(email: 'luisrodge@outlook.com', password: 'rodge24', password_confirmation: 'rodge24', type: "Admin")
end
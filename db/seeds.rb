if Admin.count != 1
  # Seed initial admin user
  Admin.create!(email: 'luisrodge@outlook.com', password: 'password', password_confirmation: 'password')
end


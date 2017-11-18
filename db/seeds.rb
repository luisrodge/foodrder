if Admin.count != 1
  # Seed initial admin user
  User.create!(email: 'luisrodge@outlook.com', password: 'rodge24', password_confirmation: 'rodge24', type: "Admin")
end

menu_categories = ['Rice and Beans', 'Sea Food', 'Chicken', 'Salads', 'Burritos', 'Burgers', 'Sandwiches', 'Pizza', 'Desserts', 'Soup']

if MenuCategory.count != 10
  menu_categories.each do |category|
    MenuCategory.create(name: category)
  end
end

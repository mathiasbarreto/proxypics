# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
puts 'Creating 100 Orders...'
100.times do
  Order.create([{ address: Faker::Address.street_address  }])
end
puts '100 Orders created!'
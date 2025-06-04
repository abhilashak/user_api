# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create a large number of users for performance testing
puts "Creating seed users..."

# Sample biographies for variety
biographies = [
  "Full-stack developer with 5 years of experience in Ruby on Rails and React.",
  "DevOps engineer specializing in AWS and Kubernetes deployments.",
  "Senior software architect with a passion for scalable systems.",
  "Machine learning engineer focused on natural language processing.",
  "Mobile app developer with expertise in iOS and Android development.",
  "Backend developer specializing in high-performance APIs.",
  "Frontend specialist with deep knowledge of modern JavaScript frameworks.",
  "Database administrator with expertise in PostgreSQL optimization.",
  "Cloud architect with experience in multi-cloud environments.",
  "Security engineer focused on API and web application security."
]

# Create 1000 users with randomized data
1000.times do |i|
  User.create!(
    name: "User #{i + 1}",
    biography: biographies.sample + " #{SecureRandom.hex(100)}"  # Add random text to make biographies unique and longer
  )
  print "." if (i + 1) % 100 == 0  # Progress indicator
end

puts "\nCreated #{User.count} users successfully!"
